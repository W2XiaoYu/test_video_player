import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_video_player/pages/splash/splash_presenter.dart';
import 'package:test_video_player/utils/dialog.dart';
import 'package:test_video_player/utils/image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SplashPresenter(
        navigateToMain: ({required String path, Map<String, dynamic>? extra}) {
      context.push(path, extra: extra);
    });
    _presenter.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadAssetImage(
              'launcher_icon',
              width: 80.w,
              height: 80.w,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.w),
            alignment: Alignment.center,
            height: 20.w,
            child: CupertinoActivityIndicator(
              radius: 12.sp,
            ),
          ),
          IconButton(
            onPressed: () {
              DialogAgreement().showAgreement(context, '标题', '这是内容', () {
                _presenter.init(context);
              });
            },
            icon: Icon(Icons.next_plan_outlined),
          ),
        ],
      ),
    );
  }
}
