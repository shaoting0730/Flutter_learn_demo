import 'package:aimoversea_admin_app/models/loginmodel.dart';
import 'package:aimoversea_admin_app/services/serviceapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Topic extends StatefulWidget {
  Topic({Key key, this.hasAppBar = true, this.topicName}) : super(key: key);

  final String topicName;
  final bool hasAppBar;

  @override
  _TopicState createState() => new _TopicState();
}

class _TopicState extends State<Topic> {
  String topicName;
  TopicModel topic;

  int tapNum = 0;

  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (topicName == null) {
      topicName = widget.topicName;
      if (topicName == null) {
        topicName = args['name'];
      }

      Future.delayed(const Duration(milliseconds: 100), () async {
        topic = await UserServerApi().getTopic(context, topicName);
        setState(() {});
      });
    }

    var background = 0xFF000000 |
        (args != null && args.containsKey('background')
            ? int.parse(args['background'])
            : 0xFFFFFF);
    return Scaffold(
      appBar: widget.hasAppBar
          ? AppBar(
              title: topic == null || topic.Title == null
                  ? Text("隐私权政策",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight))
                  : Text(topic.Title),
              centerTitle: true,
              actions: <Widget>[
                topic != null && topic.Title == '关于我们'
                    ? GestureDetector(
                        onTap: _serverTag,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.transparent,
                        ),
                      )
                    : Text(''),
              ],
            )
          : null,
      body: topic == null || topic.Body == null
          ? Text("")
          : SingleChildScrollView(
//              child: Html(
//                data: topic.Body,
//                padding: EdgeInsets.all(0.0),
//                backgroundColor: Colors.white70,
//                onLinkTap: _onLinkTap,
//                onImageTap: _onLinkTap,
//              ),
              child: Container(
                decoration: BoxDecoration(color: Color(background)),
                child: HtmlWidget(
                  topic.Body,
                  bodyPadding: EdgeInsets.all(0),
                  tableCellPadding: EdgeInsets.all(0),
                  onTapUrl: _onLinkTap,
                ),
              ),
            ),
    );
  }

  /*
  * 跳至 设置服务器页面
  * */
  _serverTag() {
    setState(() {
      tapNum++;
    });
    if (tapNum >= 5) {
      Navigator.pushNamed(context, '/server_set');
      setState(() {
        tapNum = 0;
      });
    }
  }

  _onLinkTap(String url) {
    var uri = Uri.parse(url);
    if (uri.host == 'page') {
      Navigator.pushNamed(context, uri.path, arguments: uri.queryParameters);
    }
  }
}
