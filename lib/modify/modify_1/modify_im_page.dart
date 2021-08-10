import 'package:flutter/material.dart';

//  0.0  Not used yet

class ImageInfo {
  String imageName;
  double imagrHeight;

  ImageInfo(imageName, imagrHeight) {
    this.imagrHeight = imagrHeight;
    this.imageName = imageName;
  }
}

class ModifyIMPage extends StatefulWidget {
  const ModifyIMPage({Key key}) : super(key: key);

  @override
  _ModifyIMPageState createState() => _ModifyIMPageState();
}

class _ModifyIMPageState extends State<ModifyIMPage> {
  List<ImageInfo> imageArray = [
    ImageInfo('imageName', 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
