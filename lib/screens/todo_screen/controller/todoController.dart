import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_pp/model/todo_model.dart';
import 'package:todo_pp/screens/catgories_screen/controller/category_controller.dart';
import 'package:intl/intl.dart';
import 'package:todo_pp/screens/home_screen/controller/home_controller.dart';

import '../../../constants/constants.dart';
import '../../../helper/repository.dart';

class TodoController extends GetxController{
  //related to date picker
  DateTime dateTime = DateTime.now();

  //Repository class to call database
  Repository? _repository;

  CategoriesController categoriesController = Get.put(CategoriesController());
  //related to drop down button
  dynamic selected = "".obs;
  final List<String> categoryList = <String>[].obs;

  HomeController homeController = Get.put(HomeController());

  //methods
  ///Constructor
  TodoController() {
    _repository = Repository();
  }

  /// When calling the class
  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  /// related to drop down box
  void setSelected(val){
    selected.value = val;
  }

  /// loading categories from category table
  loadCategories() async{
    var categories = await categoriesController.getCategories();

    categoryList.clear();
    categories.forEach((category){
      categoryList.add(category.name);
    });
    print('List: $categoryList ${categoryList.runtimeType}');
  }

  saveTodo(TodoModel todo) async{
    var result = await _repository!.insertData(Consts.tbToDo, todo.toMap());

    homeController.getTodos();

    showToast('Saved Successfully');
    return result;
  }

  updateTodo(TodoModel todo) async{
    var result = await _repository!.updateData(Consts.tbToDo, todo.toMap());

    homeController.getTodos();

    showToast('Updated Successfully');
    return result;
  }

  ///Toast method
  showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      fontSize: 16.0.sp,
      backgroundColor: Consts.mainColor.withOpacity(0.6),
    );
  }




}

