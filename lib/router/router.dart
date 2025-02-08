// 定义路由
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_video_player/pages/dyhome/douyin_home.dart';
import 'package:test_video_player/pages/main_page/home_chat/home_chat.dart';
import 'package:test_video_player/pages/main_page/main_page.dart';
import 'package:test_video_player/pages/main_page/mine/test_hero.dart';
import 'package:test_video_player/pages/splash/splash.dart';

import '../pages/video_player.dart';

//全局key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouterList {
  static final router = GoRouter(
    initialLocation: '/main',
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/', // 根路径
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: '/play',
        builder: (BuildContext context, GoRouterState state) {
          return VideoPlayerScreen();
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (BuildContext context, GoRouterState state) {
          return HomeChat();
        },
      ),
      GoRoute(
        path: '/main',
        builder: (BuildContext context, GoRouterState state) {
          // 初始化 index 为 0
          int index = 0;
          // 检查 state.extra 是否为 Map<String, int> 类型
          if (state.extra is Map<String, int>) {
            final extraMap = state.extra as Map<String, int>;
            // 尝试从 Map 中获取 index，如果不存在则使用默认值 0
            index = extraMap['index'] ?? 0;
          }
          return MainPage(index: index);
        },
      ),
      GoRoute(
        path: '/dy',
        builder: (BuildContext context, GoRouterState state) {
          return const DouyinHome();
        },
      ),
      GoRoute(
          path: '/test',
          builder: (BuildContext context, GoRouterState state) {
            return TestHeroPage();
          })
    ],
  );
}
