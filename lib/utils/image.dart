import 'package:flutter/material.dart';

/// 工具类：用于获取图片路径
class ImageUtils {
  /// 默认图片文件夹路径
  static const String _basePath = 'assets/images';

  /// 获取图片路径
  ///
  /// [name] 图片名称，不需要带后缀。
  /// [format] 图片格式，默认为 'png'。
  static String getImgPath(String name, {String format = 'png'}) {
    return '$_basePath/$name.$format';
  }
}

/// 自定义图片加载组件
///
/// 使用 Image.asset 加载本地图片资源，支持自定义宽高、格式等参数。
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.format = 'png',
    this.color,
    this.gaplessPlayback = false,
  });

  /// 图片名称（不包含路径和后缀）
  final String image;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 图片显示模式
  final BoxFit? fit;

  /// 图片格式，默认为 'png'
  final String format;

  /// 图片颜色，用于着色
  final Color? color;

  /// 图片是否在内容更新时保持稳定
  final bool gaplessPlayback;

  @override
  Widget build(BuildContext context) {
    // 获取图片路径
    final String imagePath = ImageUtils.getImgPath(image, format: format);

    return Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit,
      color: color,
      gaplessPlayback: gaplessPlayback,
    );
  }
}
