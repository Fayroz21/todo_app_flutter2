import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_pp/components/alertDialog.dart';
import 'package:todo_pp/screens/catgories_screen/controller/category_controller.dart';
import 'package:todo_pp/screens/home_screen/controller/home_controller.dart';
import 'package:todo_pp/screens/todo_screen/controller/todoController.dart';
import 'package:todo_pp/screens/todo_screen/todo_screen.dart';

import '../../components/drawer_navigation.dart';
import '../../components/text_button.dart';
import '../../constants/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../model/todo_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Consts.mainColor,
      ),
      drawer: DrawerNavigation(),
      body: Obx(
        () => ListView.builder(
            itemCount: homeController.todoLists.length,
            itemBuilder: (context, index) {
              print(homeController.todoLists[index].isFinished);

              return Slidable(
                startActionPane: ActionPane(
                  key: ValueKey(index),
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              title: 'Are you sure you want to Delete?',
                              func1: () {
                                homeController.deleteTodo(
                                    homeController.todoLists[index].id);
                                showToast('Delete Successfully');
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              text1: 'Delete',
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              title: 'Are you sure you want to Update?',
                              func1: () {
                                TodoScreen todoScreen = TodoScreen(
                                  buttonAppear: false,
                                );
                                todoScreen.id = homeController.todoLists[index].id!;
                                todoScreen.todoTitleController.text =
                                homeController.todoLists[index].title!;
                                todoScreen.todoDetailsController.text =
                                homeController.todoLists[index].descDo!;
                                todoScreen.todoDateController.text =
                                homeController.todoLists[index].todoDate!;
                                todoScreen.todoController.selected.value =
                                homeController.todoLists[index].category!;
                                todoScreen.statusFinished = homeController.todoLists[index].isFinished;

                                Get.to(todoScreen);
                              },
                              text1: 'Update',
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0)
                          .w,
                  child: Card(
                    color:
                        (homeController.todoLists[index].isFinished == null ||
                                homeController.todoLists[index].isFinished == 0)
                            ? Colors.white
                            : Consts.doneSign,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0).w,
                    ),
                    child: ListTile(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Are you sure it is Done?',
                              func1: () async {
                                TodoModel isFinishedSection =
                                    homeController.todoLists[index];
                                isFinishedSection.isFinished = 1;
                                //making getx detect there is a change
                                homeController.todoLists[index] =
                                    isFinishedSection;

                                await todoController.updateTodo(isFinishedSection);

                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              text1: 'Done',
                              func2: () {
                                TodoModel isFinishedSection =
                                    homeController.todoLists[index];
                                isFinishedSection.isFinished = 0;
                                //making getx detect there is a change
                                homeController.todoLists[index] =
                                    isFinishedSection;

                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              text2: 'Undo',
                            );
                          },
                        );
                      },
                      title: Text(
                        '${homeController.todoLists[index].title} \n' ??
                            'No title',
                      ),
                      subtitle: Text(
                          homeController.todoLists[index].descDo ?? 'No Desc'),
                      trailing: Text(homeController.todoLists[index].todoDate ??
                          'No Date'),
                      leading: CircleAvatar(
                          maxRadius: 30.w,
                          backgroundColor: Colors.brown.shade100,
                          child: Text(
                            homeController.todoLists[index].category ??
                                'No Category',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Consts.mainColor,
        child: const Icon(Icons.add),
        onPressed: () {
          todoController.loadCategories();
          Get.to(() => TodoScreen(
                buttonAppear: true,
              ));
        },
      ),
    );
  }
}

showToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    textColor: Colors.white,
    fontSize: 16.0.sp,
    backgroundColor: Consts.mainColor.withOpacity(1),
  );
}
