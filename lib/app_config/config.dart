import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig {
  static bool isIos = Platform.isIOS;
  static bool isAndroid = Platform.isAndroid;

  static String channel = isIos
      ? "yqclzs_ios"
      : const String.fromEnvironment("channel", defaultValue: "zwyqsa_vivo");

  ///校验手机号
  static bool isPhone(String phone) {
    return RegExp(r'^1[3456789]\d{9}$').hasMatch(phone);
  }

  ///校验密码 6位数
  static bool isPhoneCode(String code) {
    return RegExp(r'^\d{6}$').hasMatch(code);
  }

  ///是否为release版本
  static bool isProduction() {
    return kReleaseMode;
  }

  static String get getDioBaseUrl {
    if (isProduction()) {
      return _baseUrlRelease;
    } else {
      return _baseUrlRelease;
    }
  }

  static const String _baseUrlRelease = "https://wm.yuluojishu.com";
  static const String _baseUrlDebug = "https://testwm.yuluojishu.com";

  static setSystemStatusBarColor({Color? color = Colors.transparent}) {
    ///设置透明状态栏
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  ///设置状态栏文本颜色
  static setSystemStatusBarTextColor(
      {SystemUiOverlayStyle? val = SystemUiOverlayStyle.dark}) {
    SystemChrome.setSystemUIOverlayStyle(val!);
  }

  ///格式化日期 yyyy-mm-dd
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return "${date.year}-${date.month}-${date.day}";
  }

  /// 使用正则表达式替换中间的四位数字为星号
  static String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty || phoneNumber.length < 11) {
      return phoneNumber;
    }
    String maskedNumber = phoneNumber.replaceRange(3, 7, '****');

    return maskedNumber;
  }

  static const String appAesSecretKey = "QgKRssgqXpfP3d5A";
}
