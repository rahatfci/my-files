import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:my_file/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class CoreProvider extends ChangeNotifier {
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];
  List<FileSystemEntity> recentFiles = <FileSystemEntity>[];
  final isolates = IsolateHandler();
  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;
  bool storageLoading = true;
  bool recentLoading = true;

  checkSpace() async {
    setRecentLoading(true);
    setStorageLoading(true);
    recentFiles.clear();
    availableStorage.clear();
    List<Directory> dirList = (await getExternalStorageDirectories())!;
    availableStorage.addAll(dirList);
    notifyListeners();
    MethodChannel platform = MethodChannel('dev.jideguru.filex/storage');
    var free = await platform.invokeMethod('getStorageFreeSpace');
    var total = await platform.invokeMethod('getStorageTotalSpace');
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total - free);
    if (dirList.length > 1) {
      var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
      var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
      setFreeSDSpace(freeSD);
      setTotalSDSpace(totalSD);
      setUsedSDSpace(totalSD - freeSD);
    }
    setStorageLoading(false);
    getRecentFiles();
  }

  getRecentFiles() async {
    String isolateName = 'recent';
    isolates.spawn<String>(
      getFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((message) {
      recentFiles.addAll(message);
      setRecentLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  static getFilesWithIsolate(Map<String, dynamic> context) async {
    String isolateName = context['name'];
    List<FileSystemEntity> l =
        await FileUtils.getRecentFiles(showHidden: false);
    final messenger = HandledIsolate.initialize(context);
    final SendPort? send =
        IsolateNameServer.lookupPortByName('${isolateName}_2');
    send!.send(l);
    messenger.send('done');
  }

  void setFreeSpace(value) {
    freeSpace = value;
    notifyListeners();
  }

  void setTotalSpace(value) {
    totalSpace = value;
    notifyListeners();
  }

  void setUsedSpace(value) {
    usedSpace = value;
    notifyListeners();
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
    notifyListeners();
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
    notifyListeners();
  }

  void setUsedSDSpace(value) {
    usedSDSpace = value;
    notifyListeners();
  }

  void setStorageLoading(value) {
    storageLoading = value;
    notifyListeners();
  }

  void setRecentLoading(value) {
    recentLoading = value;
    notifyListeners();
  }
}
