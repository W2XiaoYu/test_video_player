import 'package:package_info_plus/package_info_plus.dart';

class AppRuntimeConfig {
  factory AppRuntimeConfig() => _singleton;

  AppRuntimeConfig._internal();

  static final AppRuntimeConfig _singleton = AppRuntimeConfig._internal();

  static AppRuntimeConfig get instance => AppRuntimeConfig();

   PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  PackageInfo getPackageInfo() => _packageInfo;
  void updatePackageInfo(PackageInfo? packageInfo) {
    if (packageInfo == null) return;
    _packageInfo = packageInfo;
  }

  String _oaid = "";

  String get oaid => _oaid;

  set oaid(String value) => _oaid;
}
