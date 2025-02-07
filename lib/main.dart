import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_video_player/app_config/config.dart';
import 'package:test_video_player/requset/dio.dart';
import 'package:test_video_player/router/router.dart';
import 'package:test_video_player/utils/darkTheme.dart';
import 'package:test_video_player/utils/lightTheme.dart';
import 'package:test_video_player/utils/logger.dart';

import 'app_config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Log.init();
  DioInstance.instance.initDio(baseUrl: AppConfig.getDioBaseUrl);
  AppRuntimeConfig.instance.getPackageInfo();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: savedThemeMode ?? AdaptiveThemeMode.light,
          builder: (theme, darkTheme) {
            return MaterialApp.router(
              title: '抖音',
              theme: theme,
              darkTheme: darkTheme,
              routerConfig: RouterList.router,
            );
          },
        );
      },
    );
  }
}
