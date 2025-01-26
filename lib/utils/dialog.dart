import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogAgreement {
  static final DialogAgreement _instance = DialogAgreement._internal();

  factory DialogAgreement() {
    return _instance;
  }

  DialogAgreement._internal();

  void showAgreement(BuildContext context, String title,
      String Textcontent, VoidCallback onConfirm) {
    showModalBottomSheet(
      context: context,
      builder: (content) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              SizedBox(height: 16.w),
              Text(Textcontent),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text('确定'),
                    onPressed: () {
                      onConfirm();
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
