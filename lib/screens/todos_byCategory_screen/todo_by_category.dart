
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_pp/screens/todos_byCategory_screen/controller/ByCategoryController.dart';

import '../../constants/constants.dart';

class TodosByCategoryScreen extends StatelessWidget {

   String? categoryName;

  TodosByCategoryScreen({Key? key,
    this.categoryName
  }) : super(key: key);

   ByCategoryController? byCategoryController;

   @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    byCategoryController = Get.put(ByCategoryController(categoryName));


    print('Name : $categoryName');
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName',),
        backgroundColor: Colors.brown.shade200,
      ),
      body: SafeArea(
        child: Obx(
            () => ListView.builder(
              itemCount: byCategoryController!.todoByCatLists.length,
              itemBuilder: (context, index){
                print(byCategoryController!.todoByCatLists[index].isFinished);

                return Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0).w,
                  child: Card(
                    color:
                    (byCategoryController!.todoByCatLists[index].isFinished == null ||
                        byCategoryController!.todoByCatLists[index].isFinished == 0)
                        ? Colors.white
                        : Consts.doneSign,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20).w,
                    ),
                    child: ListTile(
                      title: Text('${byCategoryController!.todoByCatLists[index].title} \n' ?? 'No Title'),
                      subtitle: Text(byCategoryController!.todoByCatLists[index].descDo ?? 'No Description', style: const TextStyle(
                        color: Colors.brown,
                      ),),
                      trailing: Text(byCategoryController!.todoByCatLists[index].todoDate ?? 'No Date'),
                    ),
                  ),
                );
              },
            )
        ),

      ),
    );
  }
}
