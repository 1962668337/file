import 'package:flutter/material.dart';

import 'asperct_raio_image.dart';

class Cc extends StatefulWidget {
  const Cc({Key key}) : super(key: key);

  @override
  _CcState createState() => _CcState();
}

class _CcState extends State<Cc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('image 宽高')),
        body: Container(
          child: _buildScrollView(),
        ));
  }
}

Widget _buildScrollView() {
  return SingleChildScrollView(
    //滑动的方向 Axis.vertical为垂直方向滑动，Axis.horizontal 为水平方向
    scrollDirection: Axis.vertical,
    //true 滑动到底部
    reverse: false,
    padding: EdgeInsets.all(0.0),
    //  滑动到底部回弹效果
    physics: BouncingScrollPhysics(),
    child: Center(
      //Row
      child: Column(
        children: <Widget>[
          Container(
            child: AsperctRaioImage.asset(
              'static/images/InsteadOfVideoThree.png',
              builder: (context, snapshot, url) {
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
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            child: AsperctRaioImage.asset(
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
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
