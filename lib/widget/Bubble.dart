import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 聊天气泡组件（带时间戳和状态指示）
Widget chatBubble({
  required BuildContext context,
  required String content,
  required bool isMe,
  required DateTime timestamp,
  bool isDelivered = false,
  bool isRead = false,
  Color? bubbleColor,
  Color? textColor,
}) {
  // 默认颜色配置
  final Color defaultBubbleColor = isMe
      ? const Color(0xFF0084FF) // 微信风格蓝色
      : Colors.white;
  final Color defaultTextColor = isMe ? Colors.white : Colors.black;

  // 气泡圆角逻辑
  final BorderRadius borderRadius = isMe
      ? BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
          bottomLeft: Radius.circular(16.w),
          bottomRight: Radius.circular(4.w),
        )
      : BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
          bottomLeft: Radius.circular(4.w),
          bottomRight: Radius.circular(16.w),
        );

  // 时间戳格式化
  String timeString = DateUtil.formatDate(timestamp, format: 'HH:mm');

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 8.w,
    ),
    child: Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          width: 35.w,
          child: !isMe
              ? CircleAvatar(
                  radius: 20.w,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 24.w),
                )
              : null,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // 气泡主体
              Container(
                decoration: BoxDecoration(
                  color: bubbleColor ?? defaultBubbleColor,
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.w,
                      offset: Offset(0, 2.w),
                    )
                  ],
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      style: TextStyle(
                        color: textColor ?? defaultTextColor,
                        fontSize: 16.sp,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    // 时间戳和状态指示
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeString,
                          style: TextStyle(
                            color: (textColor ?? defaultTextColor)
                                .withOpacity(0.7),
                            fontSize: 10.sp,
                          ),
                        ),
                        if (isMe) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            isRead
                                ? Icons.done_all
                                : isDelivered
                                    ? Icons.done
                                    : Icons.access_time,
                            size: 12.w,
                            color: isRead
                                ? Colors.blue[200]
                                : (textColor ?? defaultTextColor)
                                    .withOpacity(0.7),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ...[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            width: 35.w,
            child: isMe
                ? CircleAvatar(
                    radius: 20.w,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, size: 24.w),
                  )
                : null,
          )
        ]
      ],
    ),
  );
}

// 消息状态指示器
Widget _buildStatusIndicator(bool isDelivered, bool isRead) {
  return SizedBox(
    width: 16.w,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isDelivered)
          Icon(Icons.access_time, size: 12.w, color: Colors.grey),
        if (isDelivered && !isRead)
          Icon(Icons.done, size: 12.w, color: Colors.grey),
        if (isRead) Icon(Icons.done_all, size: 12.w, color: Colors.blue),
      ],
    ),
  );
}

// 通用时间格式化方法（带智能识别）
String formatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateToCheck = DateTime(timestamp.year, timestamp.month, timestamp.day);

  // 当天消息显示时间
  if (dateToCheck == today) {
    return DateUtil.formatDate(timestamp, format: 'HH:mm');
  }
  // 昨天消息显示"昨天"
  else if (dateToCheck == yesterday) {
    String timeString = DateUtil.formatDate(timestamp, format: 'HH:mm');
    return '昨天 $timeString';
  }
  // 一周内显示星期
  else if (now.difference(timestamp).inDays < 7) {
    String week = getWeekdayFromTimestamp(timestamp);
    String time = DateUtil.formatDate(timestamp, format: 'HH:mm');
    return '$week $time';
  }
  // 更早时间显示完整日期
  else {
    String timeString =
        DateUtil.formatDate(timestamp, format: 'yyyy-MM-dd HH:mm');
    return timeString;
  }
}

String getWeekdayFromTimestamp(DateTime timestamp) {
  DateTime date = timestamp;
  switch (date.weekday) {
    case 1:
      return '星期一';
    case 2:
      return '星期二';
    case 3:
      return '星期三';
    case 4:
      return '星期四';
    case 5:
      return '星期五';
    case 6:
      return '星期六';
    case 7:
      return '星期日';
    default:
      return '';
  }
}
