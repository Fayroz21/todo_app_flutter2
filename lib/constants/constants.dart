

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Consts{
  static final Color mainColor = Colors.amber.shade300;
  static final Color? doneSign =  Colors.greenAccent[100];
  static final dynamic mainSizedBox = SizedBox(height: 20.h);

  static const dbName = 'db_todolist';

  //category table
  static const tbCategory = 'categories';
  static const colCatName = 'name';
  static const colCatDesc = 'desc';

  //to do table
  static const tbToDo = 'todos';
  static const colID = 'id';
  static const colDoTitle = 'title';
  static const colDoDesc = 'doDesc';
  static const colDoCat = 'category';
  static const colDoDate = 'todoDate';
  static const colDoFinish = 'isFinished';




}