import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_pp/screens/catgories_screen/categories_screen.dart';
import 'package:todo_pp/screens/catgories_screen/controller/category_controller.dart';
import 'package:todo_pp/screens/home_screen/controller/home_controller.dart';
import 'package:todo_pp/screens/home_screen/home_screen.dart';

import '../constants/constants.dart';

class DrawerNavigation extends StatelessWidget {
  DrawerNavigation({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  CategoriesController categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
             Container(
              alignment: Alignment.center,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://w7.pngwing.com/pngs/4/736/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
                  ),
                ),
                  accountName: Text('Rachel Green'),
                  accountEmail: Text('Rachel@gmail.com'),
                  decoration: BoxDecoration(
                    color: Consts.mainColor,
                  ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Get.offAll(HomeScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('Categories'),
              onTap: () {
                Get.to(CategoriesScreen());
              },
            ),
            const Divider(),
            Obx(
              () => Column(
                children: homeController.categoriesList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
