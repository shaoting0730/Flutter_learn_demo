import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  @override
  State<BasePage> createState() {
    return BasePageState();
  }
}

class BasePageState<T extends StatefulWidget> extends State<T> {
  // a flag to display the loading Indicator
  bool shouldDisplayProgressIndicator = false;

  String title = "";

  @override
  Widget build(BuildContext context) {
    var list = [];
    list.add(pageContent(context));
    if (shouldDisplayProgressIndicator) {
      list.add(_buildProgressSpinner());
    }

    return Scaffold(
        appBar: title.isNotEmpty
            ? AppBar(title: Text(title, style: TextStyle(color: Color(0xFF3A3A3A))), backgroundColor: Colors.white)
            : null,
        body: list[0]);
  }

  Widget pageContent(BuildContext context) {
    return Container();
  }

  void displayProgressIndicator(bool display) {
    setState(() {
      shouldDisplayProgressIndicator = display;
    });
  }

  // 显示 loading spinner
  Widget _buildProgressSpinner() {
    return Stack(children: [
      Opacity(opacity: 0.5, child: const ModalBarrier(dismissible: false, color: Colors.black)),
      Center(child: CircularProgressIndicator())
    ]);
  }
}
