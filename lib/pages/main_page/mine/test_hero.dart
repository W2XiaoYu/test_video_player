import 'package:flutter/material.dart';

class TestHeroPage extends StatefulWidget {
  const TestHeroPage({super.key});

  @override
  State<TestHeroPage> createState() => _TestHeroPageState();
}

class _TestHeroPageState extends State<TestHeroPage> {
  String headImg =
      'https://imgcache.qq.com/fm/photo/album/rmid_album_720/c/P/003GdX842xFLcP.jpg?time=1506509578';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'testTag',
        child: Image.network(headImg),
      ),
    );
  }
}
