import 'dart:developer';

import 'package:test_video_player/api/model/init_data.dart';
import 'package:test_video_player/app_config/app_config.dart';
import 'package:test_video_player/app_config/config.dart';
import 'package:test_video_player/requset/dio.dart';
import 'package:test_video_player/utils/encrypt.dart';
import 'package:test_video_player/utils/logger.dart';
import 'package:test_video_player/utils/tools.dart';

class SplashApi {
  static initPackage() async {
    final Map<String, String> params = <String, String>{};
    params["channel"] = AppConfig.channel;
    final package = AppRuntimeConfig.instance.getPackageInfo();
    params["app_bundle_id"] = package.packageName;
    BaseModel result = await DioInstance.instance
        .post(path: '/api.v2.init/getInitConfig', data: params);

    InitData data = InitData.fromJson(result.data);
    final decryptData = EncryptUtils.decryptAes(data.data!);
    log(Tools.unicodeToString(decryptData));
    Log.json(Tools.unicodeToString(decryptData).toString());
  }
}
