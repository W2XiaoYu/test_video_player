import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class DouyinHome extends StatefulWidget {
  final String videoUrl;
  final bool isCurrent;

  const DouyinHome({
    super.key,
    required this.videoUrl,
    required this.isCurrent,
  });

  @override
  State<DouyinHome> createState() => _DouyinHomeState();
}

class _DouyinHomeState extends State<DouyinHome> {
  final PageController _pageController = PageController();
  List<String> videoUrls = [
    'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4',
    'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4',
    'https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4',
  ];
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: _buildBody(),
    );
  }

  Widget _buildVideo() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        setState(
          () {
            _currentPage = index;
          },
        );
      },
      itemBuilder: (context, index) {
        return VideoPlayerItem(
          videoUrl: videoUrls[index],
          isCurrent: index == _currentPage,
        );
      },
    );
  }

  Widget _buildBody() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          TabBarView(
            children: [
              Stack(children: [
                _buildVideo(),
              ]),
              Center(
                child: Text(
                  'page 2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  'page 3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).padding.top,
            child: SizedBox(
              height: 56.w,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.live_tv,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Center(
                        child: TabBar(
                          splashFactory: NoSplash.splashFactory,
                          //去掉水波纹
                          dividerHeight: 0,
                          indicatorColor: Colors.white,
                          //选中下划线的颜色
                          indicatorSize: TabBarIndicatorSize.label,
                          //选中下划线的长度
                          tabs: [
                            Tab(
                              child: Text(
                                '同城',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                '关注',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                '推荐',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12.w,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool isCurrent;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
    required this.isCurrent,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  bool _showControls = false;
  bool _isLiked = false;
  int _likeCount = 2345;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: true,
      showControls: false,
    );
    setState(() {});
    if (widget.isCurrent) {
      _videoController.play();
    }
  }

  @override
  void didUpdateWidget(VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCurrent && !widget.isCurrent) {
      _videoController.pause();
      setState(() {
        _isPaused = true;
      });
    } else if (!oldWidget.isCurrent && widget.isCurrent) {
      _videoController.play();
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _showControls = !_showControls);
      },
      child: Stack(
        children: [
          // 视频播放区域
          _videoController.value.isInitialized
              ? Chewie(controller: _chewieController)
              : Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                    color: Colors.white,
                    radius: 12,
                  ),
                ),

          //操作遮罩层
          _buildOverlayUI(),
          if (_isPaused)
            Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 240,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildOverlayUI() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, //让子元素空区域也可以点击
      onTap: () {
        // 确保控制器已初始化
        if (!_videoController.value.isInitialized) return;
        if (_videoController.value.isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
        setState(() {
          _isPaused = !_videoController.value.isPlaying;
        });
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 底部控制区域
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 左侧用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('@抖音用户',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(
                          '这是一个有趣的短视频，快来点赞吧！',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 16,
                              color: Colors.red,
                            ),
                            Text(
                              '原声 - 原创音乐',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 右侧互动按钮
                  _buildRightActionBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightActionBar() {
    return Column(
      children: [
        _buildActionButton(
          _isLiked ? Icons.favorite : Icons.favorite_border,
          '$_likeCount',
          () {
            setState(() {
              _isLiked = !_isLiked;
              _likeCount += _isLiked ? 1 : -1;
            });
          },
          color: _isLiked ? Colors.red : Colors.white,
        ),
        _buildActionButton(Icons.comment, '2345', () {}),
        _buildActionButton(Icons.share, '分享', () {}),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 20,
          backgroundImage:
              NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String text, VoidCallback onTap,
      {Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon, color: color, size: 32),
            onPressed: onTap,
          ),
          Text(text,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
