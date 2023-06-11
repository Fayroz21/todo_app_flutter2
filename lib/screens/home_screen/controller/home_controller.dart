

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_pp/model/todo_model.dart';
import 'package:todo_pp/screens/todos_byCategory_screen/todo_by_category.dart';

import '../../../constants/constants.dart';
import '../../../helper/repository.dart';
import '../../catgories_screen/controller/category_controller.dart';
import '../../todos_byCategory_screen/controller/ByCategoryController.dart';

class HomeController extends GetxController{

  Repository? _repository;
  var todoLists = <TodoModel>[].obs;

  CategoriesController categoriesController = Get.put(CategoriesController());
  final List<Widget> categoriesList = <Widget>[].obs;

  var isFinished = 0.obs;

  ///Constructor
  HomeController(){
    _repository = Repository();
  }

  ///Init
  @override
  void onInit() {
    super.onInit();
    getTodos();
    getAllCategoriesNames();
  }

  ///Get data
  getTodos() async {
    var todos = await _repository!.getData(Consts.tbToDo);

    List<TodoModel> local = [];
    if (todos != null) {
      todos.forEach((todo) {
        local.add(TodoModel.fromMap(todo));
      });
    } else {
      print('No data found');
    }

    todoLists.value = local;
    return todoLists;
  }

  getAllCategoriesNames() async{
    var categories = await categoriesController.getCategories();

    categoriesList.clear();
    categories.forEach((category){
      print('Names : ${category.name}');
      categoriesList.add(InkWell(
        onTap: (){
          Get.to(TodosByCategoryScreen(categoryName: category.name,));
        },
        child: ListTile(
          title: Text(category.name),
        ),
      ));
    });
  }

  deleteTodo(index) async {
    var result = await _repository!.deleteData(Consts.tbToDo, index);
    getTodos();
    return result;
  }


}

