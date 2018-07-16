import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juejin/views/detail.dart';
import 'dart:io';
import 'dart:convert';

var tabs = [
  {
    'title': '首页',
    'url':
        'https://recommender-api-ms.juejin.im/v1/get_recommended_entry?suid=V77uAujvbZmYBbN3mJ37&ab=welcome_3&src=web',
    'type': 'INDEX'
  },
  {
    'title': '前端',
    'url':
        'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=web&limit=20&category=5562b415e4b00c57d9b94ac8',
    'type': 'FE'
  },
  {
    'title': '安卓',
    'url':
        'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=web&limit=20&category=5562b410e4b00c57d9b94a92',
    'type': 'ANDROID'
  },
  {
    'title': '后端',
    'url':
        'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=web&limit=20&category=5562b419e4b00c57d9b94ae2',
    'type': 'BE'
  },
  {
    'title': 'iOS',
    'url':
        'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=web&limit=20&category=5562b405e4b00c57d9b94a41',
    'type': 'IOS'
  },
  {
    'title': '运维',
    'url':
        'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=web&limit=20&category=5b34a478e1382338991dd3c1',
    'type': 'OPS'
  }
];

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 6,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('掘金'),
                bottom: TabBar(
                  isScrollable: false,
                  tabs: tabs.map((Map item) {
                    return Tab(child: Text(item['title']));
                  }).toList(),
                ),
              ),
              body: TabBarView(
                  children: tabs.map((Map item) {
                return IndexItem(item['type'], item['url']);
              }).toList()),
//              bottomNavigationBar: BottomNavigationBar(
//                  type: BottomNavigationBarType.fixed,
//                  items: [
//                    BottomNavigationBarItem(
//                        icon: Icon(Icons.home), title: const Text('home')),
//                    BottomNavigationBarItem(
//                        icon: Icon(Icons.chat_bubble_outline),
//                        title: const Text('message')),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.search),
//                      title: const Text('search'),
//                    ),
//                    BottomNavigationBarItem(
//                        icon: Icon(Icons.person_outline),
//                        title: const Text('user'))
//                  ]),
            )));
  }
}

class IndexItem extends StatefulWidget {
  String type;
  String url;

  IndexItem(this.type, this.url);

  @override
  createState() => new IndexItemState(this.type, this.url);
}

class IndexItemState extends State<IndexItem> {
  String type;
  String url;

  IndexItemState(this.type, this.url);

  List<Object> list = [];

  _get() async {
    var responseBody;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    print('http response status: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      await responseBody['d'] == null
          ? []
          : ('INDEX' == type
              ? responseBody['d']
              : responseBody['d']['entrylist']).map((Object item) {
              list.add(item);
            }).toList();
      setState(() {
        list:
        list;
      });
    } else {
      print("error");
    }
  }

  Future<Null> _refresh() async {
    list.clear();
    await _get();
    return;
  }

  @override
  void initState() {
    _get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: new ListView(
          children: list.map((Object item) {
            var tempItem = json.decode(json.encode(item));
            return GestureDetector(
              child: Column(
                children: <Widget>[
                  Divider(),
                  new ListTile(
                      title: Text(tempItem['title']),
                      subtitle: Text([
                        tempItem['collectionCount'],
                        '人喜欢.',
                        tempItem['user']['username'],
                        '.',
                        '1天前'
                      ].join('')),
                      trailing: tempItem['screenshot'] != null &&
                              tempItem['screenshot'] != ''
                          ? Image.network(
                              tempItem['screenshot'],
                              width: 60.0,
                              height: 60.0,
                            )
                          : Text('')),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(tempItem['originalUrl'])));
              },
            );
          }).toList(),
        ),
        onRefresh: _refresh);
  }
}
