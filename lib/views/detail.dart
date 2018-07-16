import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Detail extends StatelessWidget {
  var url;

  Detail(this.url);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//            title: const Text('mmtou'),
//            leading: new IconButton(
//              tooltip: '返回',
//              icon: const Icon(Icons.keyboard_backspace),
//              onPressed: () {
//                Navigator.pop(context);
//              },
//            )),
//        body: Center(
//          child: Text('详情'),
//        ),
//      ),
      routes: {
        "/": (_) => WebviewScaffold(
              url: url,
              appBar: new AppBar(
                  title: const Text('mmtou'),
                  leading: new IconButton(
                    tooltip: '返回',
                    icon: const Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            )
      },
    );
  }
}
