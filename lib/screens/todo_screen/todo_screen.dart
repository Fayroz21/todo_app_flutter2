import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:todo_pp/components/dropDown_btn.dart';
import 'package:todo_pp/components/elevated_btn.dart';
import 'package:todo_pp/components/text_field.dart';
import 'package:todo_pp/model/todo_model.dart';
import 'package:todo_pp/screens/home_screen/home_screen.dart';
import 'package:todo_pp/screens/todo_screen/controller/todoController.dart';

import '../../constants/constants.dart';

class TodoScreen extends StatelessWidget {

  bool? buttonAppear;
  TodoController todoController = Get.put(TodoController());

  TodoScreen({Key? key,
    required this.buttonAppear
  }) : super(key: key);

  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDetailsController = TextEditingController();
  TextEditingController todoDateController = TextEditingController();
  int? statusFinished;
  int? id;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
        backgroundColor: Consts.mainColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25).w,
            child: Column(
              children: [
                CustomTextField(
                    hint: 'Write what to do',
                    label: 'Title',
                    controller: todoTitleController,
                  textCapitalization: TextCapitalization.words,
                ),
                Consts.mainSizedBox,
                CustomTextField(
                    hint: 'To do details',
                    label: 'Details',
                    controller: todoDetailsController),
                Consts.mainSizedBox,
                CustomTextField(
                  hint: 'Pick a Date',
                  label: 'Date',
                  controller: todoDateController,
                  keyType: TextInputType.datetime,
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                  ),
                ),
                Consts.mainSizedBox,
                Obx(() =>
                    CustomDropDownButton(
                        hintText: 'Category',
                        selectedValue: todoController.selected.value == ""
                            ? null
                            : todoController.selected.value,
                        items: todoController.categoryList,
                        function: (val) {
                          todoController.setSelected(val);
                        })
                ),

                Builder(builder: (context) {
                  if(buttonAppear == true) {
                    return CustomElevatedBtn(onPrassed: () {
                      var todoObject = TodoModel(
                        title: todoTitleController.text,
                        descDo: todoDetailsController.text,
                        todoDate: todoDateController.text,
                        category: todoController.selected.value,
                        isFinished: 0,
                      );
                      var result = todoController.saveTodo(todoObject);
                      print('Result : $result');
                      todoTitleController.clear();
                      todoDetailsController.clear();
                      todoDateController.clear();
                      todoController.selected.value = "";
                    });
                  }
                  return CustomElevatedBtn(
                      text: 'Update',
                      onPrassed: () {
                        TodoModel todoModel = TodoModel();
                        todoModel.id = id;
                        todoModel.title = todoTitleController.text;
                        todoModel.descDo = todoDetailsController.text;
                        todoModel.todoDate = todoDateController.text;
                        todoModel.category = todoController.selected.value;
                        todoModel.isFinished = statusFinished;
                        todoController.updateTodo(todoModel);

                        todoTitleController.clear();
                        todoDetailsController.clear();
                        todoDateController.clear();
                        todoController.selected.value = "";

                        Get.offAll(HomeScreen());

                      });
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: todoController.dateTime,
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) {
      todoController.dateTime = _pickedDate;
      todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
    }
  }
}
