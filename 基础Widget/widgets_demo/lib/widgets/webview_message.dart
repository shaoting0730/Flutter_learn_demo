import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // 获取项目中的html文件
  Future<String> _getFile() async {
    return await rootBundle.loadString('images/my_html.html');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebView(
            initialUrl: Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                .toString(),
          );
        } else {
          return Text('获取本地html失败');
        }
      },
    );
  }
}
