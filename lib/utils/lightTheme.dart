import 'package:flutter/material.dart';

import 'darkTheme.dart';

// 定义清新明亮风格的 ThemeData
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  // 启用 Material 3
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // 主色调（种子颜色）
    brightness: Brightness.light, // 明亮模式
    // surface: Colors.blue
  ),

  extensions: <ThemeExtension<dynamic>>[
    const CustomBottomBarThemeData(
      backgroundColor: Colors.white,
      // 默认背景色为白色
      color: Colors.grey,
      // 默认文字和图标颜色为灰色
      curveSize: 15.0,
      // 凸性大小
      height: 70.0,
      // 高度
      activeColor: Colors.blue,
      // 激活颜色为蓝色
      top: 10.0, // 凸形到 AppBar 上边缘的距离
    ),
  ],
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.white, //背景色
    elevation: 1, //阴影
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    // 设置底部导航栏背景色
    selectedItemColor: Colors.blue,
    // 设置选中项颜色
    unselectedItemColor: Colors.grey,
    // 设置未选中项颜色
    elevation: 1,
    // 设置导航栏的阴影效果
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: Colors.blue,
    foregroundColor: Colors.black,
    // AppBar 前景颜色（文字、图标）
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    elevation: 2, // 阴影高度
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // 按钮背景颜色
      foregroundColor: Colors.white, // 按钮文字颜色
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    elevation: 4,
    margin: EdgeInsets.all(10),
  ),
);
