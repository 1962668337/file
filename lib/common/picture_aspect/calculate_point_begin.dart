//计算文件里面有几个文件

import 'dart:io';
import 'package:path/path.dart' as p;

// 读取文件夹里面有几个文件
// 计数 内部有几个文件

// 计算以 . 开头的文件、文件夹总数
int textcalculatePointBegin(List<FileSystemEntity> fileList) {
  int count = 0;
  for (var v in fileList) {
    if (p.basename(v.path).substring(0, 1) == '.') count++;
  }
  return count;
}

// 计算文件夹内 文件、文件夹的数量，以 . 开头的除外
int calculateFilesCountByFolder(Directory path) {
  var dir = path.listSync(); // 同步列表
  int count = dir.length - textcalculatePointBegin(dir);
  return count;
}
