import 'package:flutter/services.dart';
import 'package:test_video_player/app_config/app_config.dart';

class OAID {
  static const MethodChannel _channel = MethodChannel('device_identity');

  static Future<void> getOAID() async {
    String id = await _channel.invokeMethod('getOAID') ?? "";
    AppRuntimeConfig.instance.oaid = id;
  }
}
