import 'package:flutter_file_manager/modify/modify_1/list_page_one.dart';
import 'package:flutter_file_manager/modify/photo_widght/photo_page_4.dart';
import 'package:flutter_file_manager/modify/photo_widght/photo_page_5.dart';
import 'package:flutter_file_manager/common/picture_aspect/picture_jump_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'globalState_controller.dart';

import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';

// 底部导航
// ignore: must_be_immutable
class BottomMenuPage extends StatelessWidget {
  final globalStateController = Get.put(GlobalStateController());
  var mainState = Get.find<GlobalStateController>().state;

  List<Widget> bodyPageList = [
    PhotoPage5(),
    PictureJumpPage(),
    PhotoPage4(),
    ListPageOne(),
  ];

  bool navBarMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //主题
      body: Obx(() => bodyPageList[mainState.bottombarIindex.value]),

      bottomNavigationBar: Obx(
        () => TitledBottomNavigationBar(
          currentIndex: mainState.bottombarIindex.value,

          onTap: (int index) {
            globalStateController.changeBottomBarIndex(index);
          },
          reverse: navBarMode,
          curve: Curves.easeInBack, //曲线 缓入后退
          activeColor: Colors.green,
          inactiveColor: Colors.blueGrey,

          items: [
            TitledNavigationBarItem(title: Text('5'), icon: Icons.home),
            TitledNavigationBarItem(title: Text('5中长按'), icon: Icons.home),
            TitledNavigationBarItem(title: Text('4'), icon: Icons.home),
            TitledNavigationBarItem(title: Text('ListPage'), icon: Icons.home),
          ],
        ),
      ),
    );
  }
}
