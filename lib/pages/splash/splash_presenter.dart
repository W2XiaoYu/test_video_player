import 'package:flutter/src/widgets/framework.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:test_video_player/api/splash.dart';
import 'package:test_video_player/app_config/app_config.dart';
import 'package:test_video_player/utils/oaid.dart';

class SplashPresenter {
  final void Function({
    required String path,
    Map<String, dynamic>? extra,
  }) navigateToMain;

  SplashPresenter({required this.navigateToMain});

  void init(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    AppRuntimeConfig.instance.updatePackageInfo(info);
    if (AppRuntimeConfig.instance.oaid.isEmpty) {
      await OAID.getOAID();
    }
    await SplashApi.initPackage();
    navigateToMain(path: '/main', extra: {'index': 1});
    // Simulate a delay to show the loading indicator
    // Future.delayed(Duration(seconds: 2), () {
    //   navigateToMain(path: '/main', extra: {'index': 1});
    // });
  }
}
