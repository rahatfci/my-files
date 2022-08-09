import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_file/widgets/dir_popup.dart';
import 'package:path/path.dart';

class DirectoryItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function tap;
  final Function? popTap;

  DirectoryItem({
    Key? key,
    required this.file,
    required this.tap,
    this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => tap(),
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            Icons.folder_copy_outlined,
          ),
        ),
      ),
      title: Text(
        '${basename(file.path)}',
        style: TextStyle(
          fontSize: 14,
        ),
        maxLines: 2,
      ),
      trailing: popTap == null
          ? null
          : DirPopup(
              path: file.path,
              popTap: popTap,
            ),
    );
  }
}
