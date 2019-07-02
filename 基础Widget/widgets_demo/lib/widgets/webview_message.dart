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

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: WebView(
              initialUrl:
                  Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                      .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <JavascriptChannel>[
                _alertJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('js://webview')) {
                  print('js call flutter1');
                  print(request);
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
            floatingActionButton: jsButton(),
          );
        } else {
          return Text('获取本地html失败');
        }
      },
    );
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'shaoting',
        onMessageReceived: (JavascriptMessage message) {
          print('js call flutter2');
          print(message.message);
        });
  }

  Widget jsButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                _controller.future.then((controller) {
                  controller
                      .evaluateJavascript('callJS("Flutter call JS")')
                      .then((result) {});
                });
              },
              child: Text('call JS'),
            );
          }
          return Container();
        });
  }
}
