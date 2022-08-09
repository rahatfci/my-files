import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_file/providers/providers.dart';
import 'package:my_file/screens/ios_error.dart';
import 'package:my_file/screens/splash.dart';
import 'package:my_file/utils/utils.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, appProvider, Widget? child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: AppStrings.appName,
          theme: appProvider.theme,
          darkTheme: ThemeConfig.darkTheme,
          home: Platform.isIOS ? IosError() : Splash(),
        );
      },
    );
  }
}
