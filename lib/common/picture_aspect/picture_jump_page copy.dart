import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_file_manager/common/custom_color.dart';
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
      /* //appBar
      appBar: AppBar(
          title: Text(currentDir.path == Common().rootPath
              ? '查看'
              : p.basename(currentDir.path)),
          centerTitle: true,
          backgroundColor: CustomColor.topNavigationColor,
          elevation: 0.0),
          */
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
    print("要显示的文件 -222:----- ${_buildImage(file.path)}");
    return InkWell(
      onTap: () {
        OpenFile.open(file.path);
      },
      child: Container(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: _buildImage(file.path),
          ),
        ),
      ),
    );
  }

  // 读取文件类型
  Widget _buildImage(String path) {
    switch (p.extension(path)) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.webp':
        return Container(
          /*  child: AsperctRaioImage.asset(
          'static/images/InsteadOfVideoThree.png',
          builder: (context, snapshot, url) {
            // print('width=${snapshot.data.width}');
            // print('heiht=${snapshot.data.height}');
            return Column(
              children: <Widget>[
                Text(
                  '大小--${snapshot.data.width.toDouble()}x${snapshot.data.height.toDouble()}',
                  style: TextStyle(fontSize: 17.0),
                ),
                Container(
                  width: snapshot.data.width.toDouble() /
                      (snapshot.data.width / 360),
                  height: snapshot.data.height.toDouble() /
                      (snapshot.data.width / 360),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(url),
                      fit: BoxFit.cover,),),
                )
              ],
            );
          },
        ),*/

          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.scaleDown, //图片可以完整显示，但是可能不能填充满。
              // fit: BoxFit.cover, //图片可以填充满。

              image: FileImage(File(path)),
            ),
          ),
        );
      default:
        return Image.asset(
          Common().selectIcon(p.extension(path)),
        );
    }
  }

  // 获取 路径
  void getCurrentPathFiles(String path) {
    try {
      //  currentDir = Get.currentRoute as Directory;
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
