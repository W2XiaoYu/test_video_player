import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_video_player/widget/Bubble.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      // 延迟滚动，确保键盘弹出后视图滚动
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); // 更简洁的取消焦点方式
              },
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return chatBubble(
                    context: context,
                    timestamp: DateTime.now(),
                    isDelivered: true,
                    isRead: true,
                    content: 'this is home chat page,this index is $index',
                    isMe: index % 2 == 0,
                  );
                },
                itemCount: 99,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              spacing: 10.w,
              children: [
                Icon(Icons.record_voice_over),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(),
                    maxLines: 1,
                    controller: _textController,
                  ),
                ),
                Icon(Icons.account_circle_rounded),
                Icon(Icons.add),
                Icon(Icons.send)
              ],
            ),
          )
        ],
      ),
    );
  }
}
