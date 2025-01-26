// 定义深邃暗黑风格的 ThemeData
import 'dart:ui';

import 'package:flutter/material.dart';

// 定义自定义主题扩展
@immutable
class CustomBottomBarThemeData
    extends ThemeExtension<CustomBottomBarThemeData> {
  final Color backgroundColor; // 背景色
  final Color color; // 文字和图标颜色
  final double curveSize; // 凸性大小
  final double height; // 高度
  final Color activeColor; // 激活颜色
  final double top; // 凸形到 AppBar 上边缘的距离

  const CustomBottomBarThemeData({
    this.backgroundColor = Colors.white, // 默认背景色为白色
    this.color = Colors.grey, // 默认文字和图标颜色为灰色
    this.curveSize = 0.0, // 默认无凸性
    this.height = 60.0, // 默认高度
    this.activeColor = Colors.blue, // 默认激活颜色为蓝色
    this.top = 15.0, // 默认无凸形偏移
  });

  @override
  CustomBottomBarThemeData copyWith({
    Color? backgroundColor,
    Color? color,
    double? curveSize,
    double? height,
    Color? activeColor,
    double? top,
  }) {
    return CustomBottomBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: color ?? this.color,
      curveSize: curveSize ?? this.curveSize,
      height: height ?? this.height,
      activeColor: activeColor ?? this.activeColor,
      top: top ?? this.top,
    );
  }

  @override
  CustomBottomBarThemeData lerp(
      ThemeExtension<CustomBottomBarThemeData>? other, double t) {
    if (other is! CustomBottomBarThemeData) {
      return this;
    }
    return CustomBottomBarThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      color: Color.lerp(color, other.color, t)!,
      curveSize: lerpDouble(curveSize, other.curveSize, t)!,
      height: lerpDouble(height, other.height, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      top: lerpDouble(top, other.top, t)!,
    );
  }
}

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  // 启用 Material 3
  extensions: <ThemeExtension<dynamic>>[
    CustomBottomBarThemeData(
      backgroundColor: Colors.grey.shade900,
      // 默认背景色为白色
      color: Colors.grey,
      // 默认文字和图标颜色为灰色
      curveSize: 15.0,
      // 凸性大小
      height: 70.0,
      // 高度
      activeColor: Colors.lightBlue,
      // 激活颜色为蓝色
      top: 10.0, // 凸形到 AppBar 上边缘的距离
    ),
  ],
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey.shade900, //背景色
    elevation: 1, //阴影
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade900,
    // 设置底部导航栏背景色
    selectedItemColor: Colors.lightBlue,
    // 设置选中项颜色
    unselectedItemColor: Colors.grey,
    // 设置未选中项颜色
    elevation: 1,
    // 设置导航栏的阴影效果
    type: BottomNavigationBarType.fixed,
    // 设置导航栏类型为固定类型
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // 主色调（种子颜色）
    brightness: Brightness.dark, // 暗黑模式
  ),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
    backgroundColor: Colors.grey[2333],
    // AppBar 背景颜色
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    foregroundColor: Colors.white,
    // AppBar 前景颜色（文字、图标）
    elevation: 2, // 阴影高度
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 14, color: Colors.white60),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // 按钮背景颜色
      foregroundColor: Colors.white, // 按钮文字颜色
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  cardTheme: const CardTheme(
    color: Colors.grey,
    elevation: 4,
    margin: EdgeInsets.all(10),
  ),
);
