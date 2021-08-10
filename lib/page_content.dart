import 'package:flutter/material.dart';

class PageContent extends StatelessWidget {
  final String name;
  const PageContent(this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
    );
  }
}
