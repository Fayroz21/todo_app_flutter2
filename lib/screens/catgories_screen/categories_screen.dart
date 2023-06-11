import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_pp/model/category_model.dart';
import 'package:todo_pp/screens/catgories_screen/controller/category_controller.dart';
import 'package:todo_pp/screens/home_screen/controller/home_controller.dart';
import 'package:todo_pp/screens/home_screen/home_screen.dart';

import '../../components/text_button.dart';
import '../../components/text_field.dart';
import '../../constants/constants.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  CategoriesController catController = Get.put(CategoriesController());
  CategoryModel? categoryModel = CategoryModel();

  TextEditingController? categoryNameController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();

  TextEditingController? categoryNameUpdate = TextEditingController();
  TextEditingController? descriptionUpdate = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Consts.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            homeController.getAllCategoriesNames();
            Get.to(() => HomeScreen());
          },
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: catController.categoryLists.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0.h, left: 10.0.w, right: 10.0.w),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: const Icon(
                    Icons.category,
                    color: Colors.teal,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${catController.categoryLists[index].name}'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _showFormDialog(
                                  context: context,
                                  controller1: categoryNameUpdate,
                                  controller2: descriptionUpdate,
                                  function: () async{
                                    CategoryModel updateCat = CategoryModel();
                                    updateCat.id = catController.categoryLists[index].id;
                                    updateCat.name = categoryNameUpdate!.text;
                                    updateCat.desc = descriptionUpdate!.text;

                                    catController.updateCategory(updateCat);

                                    categoryNameUpdate!.clear();
                                    Navigator.of(context, rootNavigator: true).pop();


                                  },
                                  title: 'Category Update',
                                  txtBtn: 'Update',

                              );
                              categoryNameUpdate!.text = catController.categoryLists[index].name!;
                              descriptionUpdate!.text = catController.categoryLists[index].desc!;


                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                              onPressed: () async {
                                var resultDelete =
                                    await catController.deleteCategory(
                                        catController.categoryLists[index].id);
                                if (resultDelete > 0) {
                                  print('From screen : deleted');
                                }
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.red)),
                        ],
                      )
                    ],
                  ),
                  subtitle: Text('${catController.categoryLists[index].desc}'),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(
              controller1: categoryNameController,
              controller2: descriptionController,
              context: context,
              txtBtn: 'Okay',
              function: () async {
                //set values of category class
                categoryModel!.name = categoryNameController?.text;
                categoryModel!.desc = descriptionController?.text;
                //Save our data
                var result = catController.saveCategory(categoryModel!);
                print('Result hello :  ${result}');
                //clear
                categoryNameController?.clear();
                descriptionController?.clear();
                //close the form
                Navigator.of(context, rootNavigator: true).pop();
              },
              title: 'Categories Form',
          );
        },
        backgroundColor: Consts.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  _showFormDialog({required BuildContext context, txtBtn, function, title, required controller1, required controller2}) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  text: 'Cancel'),
              CustomTextButton(
                  onPressed: function,
                  // () async {
                  // //set values of category class
                  // categoryModel!.name = categoryNameController?.text;
                  // categoryModel!.desc = descriptionController?.text;
                  // //Save our data
                  // var result = catController.saveCategory(categoryModel!);
                  // print('Result hello :  ${result}');
                  // //clear
                  // categoryNameController?.clear();
                  // descriptionController?.clear();
                  // //close the form
                  // Navigator.of(context, rootNavigator: true).pop();
                  // },
                  text: txtBtn),
            ],
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    hint: 'Write a Category',
                    label: 'Category',
                    controller: controller1,
                  ),
                  CustomTextField(
                    hint: 'Write a Description',
                    label: 'Description',
                    controller: controller2,
                  )
                ],
              ),
            ),
          );
        });
  }
}
