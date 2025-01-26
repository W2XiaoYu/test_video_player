import 'package:encrypt/encrypt.dart';
import 'package:test_video_player/app_config/config.dart';

class EncryptUtils {
  /// Aes解密
  static String decryptAes(String context,
      {String key = AppConfig.appAesSecretKey}) {
    final encryptAes =
        Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb, padding: "PKCS7"));
    return encryptAes.decrypt(Encrypted.fromBase64(context),
        iv: IV.fromLength(16));
  }
}
