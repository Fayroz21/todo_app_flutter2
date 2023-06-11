

import 'package:get/get.dart';
import 'package:todo_pp/constants/constants.dart';
import 'package:todo_pp/helper/repository.dart';
import 'package:todo_pp/model/todo_model.dart';

class ByCategoryController extends GetxController{
  Repository? _repository;
  var categoryName;

  var todoByCatLists = <TodoModel>[].obs;

  ByCategoryController(this.categoryName) {
    _repository = Repository();
    readTodoByCat();
  }

  @override
  void onInit() {
    super.onInit();
    // readTodoByCat();
  }

  readTodoByCat() async{
    var todos = await _repository!.readDataByColumnName(Consts.tbToDo, Consts.colDoCat, categoryName);

    List<TodoModel> local = [];
    if(todos != null){
      todos.forEach( (todo){
        local.add(TodoModel.fromMap(todo));
      });
    }else{
      print('Not Found');
    }

    todoByCatLists.value = local;
    print('Todo: ${todoByCatLists}');
    return todoByCatLists;
  }
}