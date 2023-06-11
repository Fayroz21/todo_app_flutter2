import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_pp/components/text_button.dart';

class CustomAlertDialog extends StatelessWidget {
  String? title;
  VoidCallback? func1;
  String? text1;
  VoidCallback? func2;
  String? text2;

  CustomAlertDialog({Key? key,
    required this.title,
    required this.func1,
    required this.text1,

     this.func2,
     this.text2 = ' ',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        CustomTextButton(onPressed: func2, text: text2),
        CustomTextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop();
            },
            text: 'Cancel'),
        CustomTextButton(onPressed: func1, text: text1),
      ],
    );
  }

}
