import 'package:flutter/material.dart';
import '../../utils/trahslations.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  String _lang(String key) {
    return Translations.of(context).text(key);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_lang("home")),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(_lang("zh")),
              onPressed: () {
                applic.shouldReload = true;
                applic.onLocaleChanged(new Locale('zh', ''));
              },
            ),
            RaisedButton(
              child: Text(_lang("en")),
              onPressed: () {
                applic.shouldReload = true;
                applic.onLocaleChanged(new Locale('en', ''));
              },
            ),
          ],
        ),
      ),
    );
  }
}
