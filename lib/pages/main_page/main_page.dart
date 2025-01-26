import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_video_player/pages/main_page/home_chat/home_chat.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({super.key, required this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  GlobalKey<_RowItemState> _firstKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _firstKey.currentState?.setState(() {
            _firstKey.currentState?._innerString =
                'old:' + _firstKey.currentState!._innerString;
          });
        },
        child: Icon(Icons.delete),
      ),
      body: HomeChat(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) {
            setState(
              () {
                _index = index;
              },
            );
          },
          items: [
            BottomNavigationBarItem(
                icon: _bottomTabBarIcon(iconName: Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: _bottomTabBarIcon(iconName: Icons.search),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: _bottomTabBarIcon(iconName: Icons.person),
                label: 'person')
          ]),
    );
  }

  Widget _bottomTabBarIcon({required IconData iconName}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w),
      child: Icon(
        iconName,
        size: 24.w,
      ),
    );
  }
}

class RowItem extends StatefulWidget {
  String title;

  RowItem({super.key, required this.title});

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  final color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  String _innerString = '00';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      color: color,
      width: 100.w,
      child: Text(_innerString),
    );
  }
}
