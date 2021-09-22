/*
* 编辑分享内容
* */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSharePage extends StatefulWidget {
  final String text;
  EditSharePage({Key key, @required this.text}) : super(key: key);
  @override
  _EditSharePageState createState() => _EditSharePageState();
}

class _EditSharePageState extends State<EditSharePage> {
  TextEditingController _inputContro = new TextEditingController(); // 输入框控制器
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputContro.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '编辑分享内容',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: ListView(
        children: <Widget>[
//          输入框
          Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color(0xFFBBBBBB),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                cursorColor: Color.fromRGBO(187, 187, 187, 1),
                style: TextStyle(
                  color: Color(0xFF999999),
                ),
                maxLines: 3,
                maxLength: 50,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: _inputContro,
              ),
            ),
          ),
//          提示文字
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '*请注意分享文字数量在50个字符内',
              style: TextStyle(
                color: Color(0xFF999999),
              ),
            ),
          ),
//          保存按钮
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(345),
              height: ScreenUtil().setWidth(88),
              color: Color(0xFFFFC63F),
              child: Text('保存'),
            ),
          ),
        ],
      ),
    );
  }
}
