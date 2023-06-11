

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';

class CustomTextButton extends StatelessWidget {

  VoidCallback? onPressed;
  String? text;

  CustomTextButton({Key? key,
    required this.onPressed,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return TextButton(

        onPressed: onPressed,
        child: Text('$text', style: TextStyle(
          color: Consts.mainColor,
          fontSize: 18.sp,
        ),),

    );
  }
}
