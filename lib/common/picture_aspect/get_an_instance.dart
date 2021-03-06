// 实例 根路径   // 获取文件大小  // 读取的文件类型
// 实例 根路径
class Common {
  factory Common() => _getInstance();

  static Common get instance => _getInstance();

  static Common _instance;

  static Common _getInstance() {
    if (_instance == null) {
      _instance = Common._internal();
    }
    return _instance;
  }

  Common._internal();

  String rootPath; // 根路径

  // 获取文件大小
  String getFileSize(int fileSize) {
    String str = '';
    if (fileSize < 1024) {
      str = '${fileSize.toStringAsFixed(2)}B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      str = '${(fileSize / 1024).toStringAsFixed(2)}KB';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      str = '${(fileSize / 1024 / 1024).toStringAsFixed(2)}MB';
    }
    return str;
  }

  // 读取的文件类型
  // 选择图标
  String selectIcon(String ext) {
    String iconImg = 'assets/images/unknown.png';
    switch (ext) {
      case '.ppt':
      case '.pptx':
        iconImg = 'assets/images/ppt.png';
        break;
      case '.doc':
      case '.docx':
        iconImg = 'assets/images/word.png';
        break;
      case '.xls':
      case '.xlsx':
        iconImg = 'assets/images/excel.png';
        break;
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.webp':
      case '.gif':
      case '.exif':
      case '.avif':
        iconImg = 'assets/images/image.png';
        break;
      case '.txt':
        iconImg = 'assets/images/txt.png';
        break;
      case '.mp3':
        iconImg = 'assets/images/mp3.png';
        break;
      case '.mp4':
      case '.avi':
      case '.rmvb':
      case '.mkv':
        iconImg = 'assets/images/video.png';
        break;
      case '.rar':
      case '.zip':
        iconImg = 'assets/images/zip.png';
        break;
      case '.psd':
        iconImg = 'assets/images/psd.png';
        break;
      default:
        iconImg = 'assets/images/file.png';
        break;
    }
    return iconImg;
  }
}
