import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  String? hint;
  String? label;
  TextEditingController? controller = TextEditingController();
  Widget? prefixIcon;
  TextCapitalization textCapitalization;
  dynamic keyType;


  CustomTextField({Key? key,
    required this.hint,
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.keyType,
    this.textCapitalization = TextCapitalization.sentences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: keyType,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        focusColor: Consts.mainColor,
        fillColor: Consts.mainColor.withOpacity(0.1),
        prefixIcon: prefixIcon,
        filled: true,
        labelStyle: TextStyle(
          color: Consts.mainColor,
        ),
        focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color: Consts.mainColor,
          )
        )
      ),
    );
  }
}
