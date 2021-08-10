import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_file_manager/modify/modify_1/list_page_one.dart';
import 'package:flutter_file_manager/common/picture_aspect/calculate_point_begin.dart';
import 'package:flutter_file_manager/common/custom_color.dart';
import 'package:flutter_file_manager/common/picture_aspect/get_an_instance.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_file_manager/common/picture_aspect/picture_jump_page.dart';
import 'package:get/get.dart';

class PhotoPage5 extends StatefulWidget {
  @override
  _PhotoPage5State createState() => _PhotoPage5State();
}

class _PhotoPage5State extends State<PhotoPage5> {
  List<FileSystemEntity> currentFiles = [];
  Directory currentDir;
  ScrollController controller = ScrollController();
  List<double> position = [];

  @override
  // 初始化状态
  void initState() {
    super.initState();
    getCurrentPathFiles(Common().rootPath); // 获取根路径
  }

  void jumpToPosition(bool isEnter) async {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      try {
        await Future.delayed(Duration(milliseconds: 1));
        controller?.jumpTo(position[position.length - 1]);
      } catch (e) {}
      position.removeLast();
    }
  }

  // 获取 路径
  void getCurrentPathFiles(String path) {
    try {
      currentDir = path == Common().rootPath
          ? Directory("$path/Pictures/图片/产品4")
          : Directory(path);

      List<FileSystemEntity> _files = [];
      List<FileSystemEntity> _folder = [];

      // 遍历所有文件/文件夹
      for (var v in currentDir.listSync()) {
        if (p.basename(v.path).substring(0, 1) == '.') {
          continue;
        }
        if (FileSystemEntity.isFileSync(v.path))
          _files.add(v);
        else
          _folder.add(v);
      }

      // 排序
      _files
          .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      _folder
          .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));

      //设置状态
      setState(() {
        currentFiles.clear();
        currentFiles.addAll(_folder);
        currentFiles.addAll(_files);
      });
    } catch (e) {
      print(e);
      print("目录不存在!");
    }
  }

  // 滑动返回
  Future<bool> onWillPop() async {
    if (currentDir.path !=
        Common().rootPath + "/Pictures/图片/产品1") // 如果当前路径不是根路径
    {
      getCurrentPathFiles(currentDir.parent.path);
      jumpToPosition(false);
    } else {
      SystemNavigator.pop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop, //滑动返回
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0, // 去掉阴影
          toolbarHeight: double.minPositive, // 隐藏Appbar
          backgroundColor: Colors.green, // Appbar隐藏此条也被隐藏
          centerTitle: true, // 中心标题 Appbar隐藏此条也被隐藏
          title: Text(
              currentDir?.path == Common().rootPath
                  ? ''
                  : p.basename(currentDir.path),
              style: TextStyle(color: Colors.white)),

          // 返回根路径
          leading: currentDir?.path == Common().rootPath + "/Pictures/图册/产品1"
              ? Container()
              : IconButton(
                  icon: Icon(Icons.chevron_left), onPressed: onWillPop),
        ),
        backgroundColor: CustomColor.backgroung, // 背景颜色
        body: Container(
          padding: EdgeInsets.only(top: 3, left: 4, right: 4, bottom: 3),
          child: GridView.builder(
            itemCount: currentFiles.length, // 项目数（当前的文件内容）
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1 / 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (FileSystemEntity.isFileSync(currentFiles[index].path))
                return _buildFileItem(currentFiles[index]);
              else
                return _buildFolderItem(currentFiles[index]);
            },
          ),
        ),
      ),
    );
  }

  // 文件 框架
  Widget _buildFileItem(FileSystemEntity file) {
    return Container(
      child: InkWell(
        // 点击图片 跳转 二级页面
        onTap: () {
          Get.to(ListPageOne(), arguments: file.parent);
        },
        // 双击图片 跳转 三级页面
        onDoubleTap: () {
          Get.to(PictureJumpPage(), arguments: file.parent);
        },
        // 长按图片 跳转 二级页面
        onLongPress: () {
          Get.to(PictureJumpPage(), arguments: file.parent);
        },
        child: Container(
          child: _buildImage(file.path),
        ),
      ),
    );
  }

  // 文件  （格式、显示方式）
  Widget _buildImage(String path) {
    switch (p.extension(path)) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.webp':
      case '.gif':
      case '.exif':
      case '.avif':
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.cover,
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

  // 文件夹 框架
  Widget _buildFolderItem(FileSystemEntity file) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          // 图片预览
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(file.path + "/1 (1).jpg")),
              ),
            ),
          ),

          // 计数 内部有几个文件
          Positioned(
            right: 5,
            bottom: 2,
            child: Container(
              child: Text(
                '${calculateFilesCountByFolder(file)}',
                style: TextStyle(
                  color: CustomColor.pictureFolderQuantity,
                  fontSize: 10.0,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 文件的名字
          Positioned(
            left: 5,
            bottom: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 55,
              height: 20.0,
              child: Text(
                file.path.substring(file.parent.path.length + 1),
                style: TextStyle(
                  color: CustomColor.pictureFolderName,
                  fontSize: 12.0,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis, //超出显示.....
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        getCurrentPathFiles(file.path);
        jumpToPosition(true);
      },
    );
  }
}
