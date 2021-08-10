import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_file_manager/common/picture_aspect/get_an_instance.dart';
import 'package:get/get.dart';

class PhotoZoomIn extends StatefulWidget {
  const PhotoZoomIn({Key key}) : super(key: key);

  @override
  _PhotoZoomInState createState() => _PhotoZoomInState();
}

class _PhotoZoomInState extends State<PhotoZoomIn> {
  List<FileSystemEntity> currentFiles = [];
  Directory currentDir;

  // 获取路径
  void getCurrentPathFiles(String path) {
    try {
      currentDir = Get.arguments;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  print("要显示的文件-555:----- ${Get.arguments.toString()}");
    return Container(
      child: PhotoView(
        //  imageProvider: FileImage(File(Get.arguments.toString())),
        imageProvider: AssetImage("static/images/InsteadOfVideoOne.png"),
      ),
    );
  }

  // 初始化 根路径
  void initState() {
    super.initState();
    getCurrentPathFiles(Common().rootPath);
  }

  // 滑动返回
  Future<bool> onWillPop() async {
    if (currentDir.path != Common().rootPath) {
      getCurrentPathFiles(currentDir.parent.path);
    } else {
      SystemNavigator.pop();
    }
    return false;
  }
}
