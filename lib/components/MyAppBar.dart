import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  Widget body;

  MyAppBar(this.body);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: '首页'),
                Tab(text: '前端'),
                Tab(text: '产品'),
                Tab(text: '设计'),
                Tab(text: '后端'),
                Tab(icon: Icon(Icons.more_horiz))
              ],
            ),
            title: Text('掘金'),
            centerTitle: true),
        body: this.body,
      ),
    );
  }
}
