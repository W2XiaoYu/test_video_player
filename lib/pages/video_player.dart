import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_controls.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  Future<void> _initConfig() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
          'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4'));

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: true,
          customControls: CustomVideoControls());
      _isInitialized = true;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _videoPlayerController.dispose();
  }

  List<Widget> sizedBoxes = List.generate(
      50,
      (index) => SizedBox(
            height: 60,
            child: ItemBox(
              index: index,
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Stack(
              children: [
                // 视频播放控件
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  color: Colors.black,
                  child: _videoPlayerController.value.isInitialized &&
                          _isInitialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Center(
                          child: CupertinoActivityIndicator(
                            animating: true,
                            color: Colors.white,
                            radius: 12,
                          ),
                        ),
                ),
                // 返回按钮
                Positioned(
                  top: 20,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      context.pop(); // 返回上一页
                    },
                    icon: Icon(Icons.close),
                  ),
                )
              ],
            ),
            // 底部内容
            SizedBox(
              height: 60,
              child: Text('2'),
            ),
            SizedBox(
              height: 60,
              child: Text('2'),
            ),
            SizedBox(
              height: 60,
              child: Text('2'),
            ),
            SizedBox(
              height: 60,
              child: Text('2'),
            ),
            SizedBox(
              height: 60,
              child: Text('2'),
            ),
            ...sizedBoxes,
          ],
        ),
      ),
    );
  }
}

class ItemBox extends StatelessWidget {
  final int index;

  const ItemBox({
    Key? key,
    required this.index,
  }) : super(key: key);

  Color get color => Colors.blue.withOpacity((index % 10) * 0.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      height: 56,
      child: Text(
        '第 $index 个',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
