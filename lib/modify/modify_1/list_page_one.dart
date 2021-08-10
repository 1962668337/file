import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

const double _ITEM_HEIGHT = 70.0;

//  height: snapshot.data.height.toDouble() /(snapshot.data.width / 360),

class Item {
  final String displayName;
  bool selected;
  Item(this.displayName, this.selected);
}

class ListPageOne extends StatefulWidget {
  ListPageOne({Key key}) : super(key: key);

  @override
  _ListPageOneState createState() => new _ListPageOneState();
}

class _ListPageOneState extends State<ListPageOne> {
  List<Item> _items;

  final _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    _items = new List<Item>();

    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('杜兰特', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('詹姆斯', false));

    _items.add(new Item('科比', false));
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonsWidget = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new TextButton(
            child: new Text('杜兰特'),
            onPressed: _scrollToKd,
          ),
          new TextButton(
            child: new Text('科比'),
            onPressed: _scrollToKobe,
          ),
        ],
      ),
    );

    Widget itemsWidget = new ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        shrinkWrap: true,
        children: _items.map((Item item) {
          return _singleItemDisplay(item);
        }).toList());

    for (int i = 0; i < _items.length; i++) {
      if (_items.elementAt(i).selected) {
        _scrollController.animateTo(i * _ITEM_HEIGHT,
            duration: new Duration(seconds: 2), curve: Curves.ease);
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("滚动到列表指定item位置教程"),
      ),
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: new Column(
          children: <Widget>[
            buttonsWidget,
            new Expanded(
              child: itemsWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleItemDisplay(Item item) {
    return new Container(
      height: _ITEM_HEIGHT,
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        color: new Color(0x33000000),
        child: new Text(item.displayName),
      ),
    );
  }

  void _scrollToKd() {
    setState(() {
      for (var item in _items) {
        if (item.displayName == '杜兰特') {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }

  void _scrollToKobe() {
    setState(() {
      for (var item in _items) {
        if (item.displayName == '科比') {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }
}
