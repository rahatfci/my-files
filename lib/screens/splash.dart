import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:my_file/screens/main_screen/main_screen.dart';
import 'package:my_file/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimeout() {
    return Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      requestPermission();
    } else {
      Navigate.pushPageReplacement(context, MainScreen());
    }
  }

  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      Navigate.pushPageReplacement(context, MainScreen());
    } else {
      Dialogs.showToast('Please Grant Storage Permissions');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    startTimeout();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness:
            Theme.of(context).primaryColor == ThemeConfig.darkTheme.primaryColor
                ? Brightness.light
                : Brightness.dark,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.folder,
              color: Theme.of(context).colorScheme.secondary,
              size: 70.0,
            ),
            SizedBox(height: 20.0),
            Text(
              '${AppStrings.appName}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
