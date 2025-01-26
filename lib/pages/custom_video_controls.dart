import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoControls extends StatefulWidget {
  const CustomVideoControls({super.key});

  @override
  State<CustomVideoControls> createState() => _CustomVideoControlsState();
}

class _CustomVideoControlsState extends State<CustomVideoControls> {
  late VideoPlayerValue _latestValue;
  bool _hideStuff = true;
  late VideoPlayerController controller;
  ChewieController? _chewieController;
  bool _dragging = false; //是否在拖动中
  Timer? _hideTimer;
  Timer? _initTimer;
  bool _displayTapped = false;
  Timer? _bufferingDisplayTimer;

  ChewieController get chewieController => _chewieController!;

  void _payAndPause() {
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  ///开始隐藏控制面板
  void _startHideTimer() {
    final hideControlsTimer = chewieController.hideControlsTimer.isNegative
        ? ChewieController.defaultHideControlsTimer
        : chewieController.hideControlsTimer;
    _hideTimer = Timer(hideControlsTimer, () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    setState(() {
      _hideStuff = false;

      _displayTapped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        _cancelAndRestartTimer();
      },
      child: GestureDetector(
          onTap: () {
            _cancelAndRestartTimer();
          },
          child: AbsorbPointer(
            absorbing: _hideStuff,
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: _hideStuff ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0),
                          Colors.black.withValues(alpha: 0.31),
                          Colors.black.withValues(alpha: 0.63),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _payAndPause();
                        },
                        child: controller.value.isPlaying
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: VideoProgressBar(
                          controller,
                          barHeight: 2,
                          handleHeight: 2,
                          drawShadow: true,
                          onDragStart: () {
                            setState(() {
                              _dragging = true;
                            });

                            _hideTimer?.cancel();
                          },
                          onDragUpdate: () {
                            _hideTimer?.cancel();
                          },
                          onDragEnd: () {
                            setState(() {
                              _dragging = false;
                            });

                            _startHideTimer();
                          },
                          colors: chewieController.materialProgressColors ??
                              ChewieProgressColors(
                                playedColor: Colors.white,
                                handleColor: Colors.white,
                                bufferedColor:
                                    Colors.white.withValues(alpha: 0.4),
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.4),
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _hideStuff = true;
                          chewieController.toggleFullScreen();
                        },
                        child: chewieController.isFullScreen
                            ? Icon(
                                Icons.fullscreen_exit,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(width: 15),
                    ]),
                  ),
                ),
              )
            ]),
          )),
    );
  }

  @override
  void didChangeDependencies() {
    final oldController = _chewieController;
    _chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;
    if (oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  Future<void> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if (controller.value.isPlaying || chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          _hideStuff = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    // _showAfterExpandCollapseTimer?.cancel();
  }

  void _updateState() {
    if (!mounted) return;

    setState(() {
      _latestValue = controller.value;
    });
  }
}
