

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDropDownButton extends StatelessWidget {

  dynamic selectedValue;
  List? items;
  dynamic function;
  String? hintText;

  CustomDropDownButton({Key? key,
    required this.hintText,
    required this.selectedValue,
    required this.items,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        isExpanded: true,
        dropdownColor: Colors.amber.shade200,
        value: selectedValue,
        hint: Text(hintText!),
        items: items!.map(
            (valueItem){
              return DropdownMenuItem(value: valueItem,child: Text(valueItem),);
            }
        ).toList(),
        onChanged: function,
    );
  }
}
