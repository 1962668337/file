import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_file_manager/modify/modify_1/asperct_raio_image.dart';

import 'package:flutter_file_manager/common/picture_aspect/get_an_instance.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

// 图片跳转页面

class PictureJumpPage extends StatefulWidget {
  @override
  _PictureJumpPageState createState() => _PictureJumpPageState();
}

class _PictureJumpPageState extends State<PictureJumpPage> {
  List<FileSystemEntity> currentFiles = []; // 当前路径下的文件夹和文件
  Directory currentDir; // 当前路径

  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: currentFiles.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildFileItem(currentFiles[index]);
          },
        ),
      ),
    );
  }

  // 文件
  Widget _buildFileItem(FileSystemEntity file) {
    File imgFile = File(file.path);

    Image img = Image.file(file);
    var heightValue;
    var widthValue;
    img.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
      widthValue = info.image.width / (info.image.width / 360);
      heightValue = info.image.height / (info.image.width / 360);
    }));
    return Column(
      children: <Widget>[
        Container(
          width: widthValue,
          height: heightValue,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(imgFile),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  // 获取 路径
  void getCurrentPathFiles(String path) {
    try {
      currentDir = Get.arguments; // 跳转路径

      List<FileSystemEntity> _files = [];
      for (var v in currentDir.listSync()) {
        if (p.basename(v.path).substring(0, 1) == '.') {
          continue;
        }
        if (FileSystemEntity.isFileSync(v.path)) _files.add(v);
      }

      _files
          .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      setState(() {
        currentFiles.clear();
        currentFiles.addAll(_files);
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }
}
