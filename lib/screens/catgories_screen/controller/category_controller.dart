import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_pp/helper/repository.dart';

import '../../../constants/constants.dart';
import '../../../model/category_model.dart';

class CategoriesController extends GetxController {
  Repository? _repository;

  var categoryLists = <CategoryModel>[].obs;

  CategoriesController() {
    _repository = Repository();
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  saveCategory(CategoryModel category) async {
    print('Category name : ${category.name}');
    print('Category desc : ${category.desc}');

    var result =
        await _repository!.insertData(Consts.tbCategory, category.toMap());
    getCategories();
    showToast('Saved Successfully');
    return result;
  }

  //Get data
  getCategories() async {
    var categories = await _repository!.getData(Consts.tbCategory);

    List<CategoryModel> local = [];
    if (categories != null) {
      categories.forEach((category) {
        local.add(CategoryModel.fromMap(category));
      });
    } else {
      print('No data found');
    }

    categoryLists.value = local;
    return categoryLists;
  }

  deleteCategory(index) async {
    var result = await _repository!.deleteData(Consts.tbCategory, index);
    getCategories();
    showToast('Deleted Successfully');
    return result;
  }

  updateCategory(CategoryModel category) async {
    print('Category id : ${category.id}');
    var result =
        await _repository!.updateData(Consts.tbCategory, category.toMap());
    getCategories();
    showToast('Updated Successfully');
    return result;
  }

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
