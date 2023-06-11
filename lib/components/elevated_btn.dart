

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomElevatedBtn extends StatelessWidget {
  VoidCallback? onPrassed;
  String? text;

  CustomElevatedBtn({Key? key,
    required this.onPrassed,
    this.text = 'Save'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPrassed ,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Consts.mainColor),
        ),
        child: Text('$text'),

      ),
    );
  }
}
