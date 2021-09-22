import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() {
    return FeedbackPageState();
  }
}

class FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('投放广告'),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(children: <Widget>[_buildFeedbackEdit(), _buildPostButton()]),
        ));
  }

  Widget _buildPostButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 74, 0, 0),
      width: double.infinity,
      child: MaterialButton(
          height: 44,
          child: Text(
            "提交",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          color: Color(0xFFFFAF4C),
          onPressed: () => Navigator.pop(context)),
    );
  }

  Widget _buildFeedbackEdit() {
    return Container(
        child: TextField(
            maxLines: 6,
            decoration: InputDecoration(hintText: '请输入您的建议', border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFBBBBBB)))),
            keyboardType: TextInputType.multiline));
  }
}
