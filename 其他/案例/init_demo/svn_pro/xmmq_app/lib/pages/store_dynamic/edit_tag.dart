/*
* 编辑标签
* */
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/event_bus.dart';

class EditTagPage extends StatefulWidget {
  final List list;
  final int num;
  final String tag;
  EditTagPage({Key key, this.list, this.num, this.tag}) : super(key: key);

  @override
  _EditTagPageState createState() => _EditTagPageState();
}

class _EditTagPageState extends State<EditTagPage> {
  final _tagEditController = TextEditingController();
  bool _isEditBtn = true; // 编辑按钮 / 完成按钮 标识符
  List _tagList = []; // 标签数组

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print('2222');
    _getTagList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tagEditController.dispose();
  }

  /*获取本地标签*/
  _getTagList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List list = prefs.getStringList('TAG');

    list = list ?? [];
    Set set = list.toSet();
    List result_list = set.toList();
    for (var i = 0; i < result_list.length; i++) {
      if (result_list[i] == '') {
        result_list.removeAt(i);
      }
    }

    setState(() {
      _tagList = result_list;
    });

    widget.list.forEach((e) {
      _tagEditController.text += ' $e';
    });

//    print('历史标签 $list');
  }

  /*
  * 保存按钮点击
  * */
  _okAction() async {
    Future.delayed(Duration(milliseconds: 200)).then((e) async {
      String str = _tagEditController.text;
      List list = str.split(' ');
      if (list.contains('+ 编辑标签') == false) {
        list.add('+ 编辑标签');
      }
      if (widget.tag == 'image') {
        if (list.length != -1) {
          eventBus.fire(new TagEvent(list, widget.num)); // 先发
        }
      } else {
        if (list.length != 1) {
          eventBus.fire(new TagEvent(list, widget.num)); // 先发
        }
      }

      // 本地化
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var result = prefs.getStringList('TAG');
      if (result == null) {
        result = [];
      }
      list = result + list;
      if (list.contains('+ 编辑标签') == true) {
        list.remove('+ 编辑标签');
      }
      print('点击完成');
      print(list);
      prefs.setStringList('TAG', list);

      // 再返回
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          '编辑标签',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                _productDescWidget(), // 输入框
                Text(
                  '  *不同标签用空格隔开',
                  style: TextStyle(color: Color(0xFF999999)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('  历史标签 (可选)'),
                      _editTagWidget(), //按钮
                    ],
                  ),
                ),
                _historyTag(), // 历史标签
              ],
            ),
          ),
          InkWell(
            onTap: _okAction,
            child: Container(
              alignment: Alignment(0.0, 0.0),
              color: Color.fromRGBO(255, 175, 76, 1),
              height: 44,
              child: Text(
                '保存',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  /*
  * 历史标签
  * */
  Widget _historyTag() {
    if (_tagList.length != 0) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _tagList.map((childNode) {
            return Stack(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    if (_isEditBtn == true) {
                      print('添加到输入框');
                      if (_tagEditController.text.contains(childNode)) {
                        return;
                      }
                      _tagEditController.text += ' $childNode ';
                    } else {
                      print('删除该标签');
                      setState(() {
                        _tagList.remove(childNode);
                      });
                    }
                  },
                  child: GestureDetector(
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(241, 241, 241, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          childNode,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(102, 102, 102, 1),
                            shadows: [
                              BoxShadow(
                                  color: Color(0xFF999999),
                                  offset: Offset(0.2, 0.2))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _isEditBtn == false
                    ? Positioned(
                        top: 2,
                        right: 2,
                        child: Icon(
                          Icons.cancel,
                          size: 20,
                          color: Color(0xFF999999),
                        ),
                      )
                    : Text('')
              ],
            );
          }).toList(),
        ),
      );
    } else {
      return Text('');
    }
  }

  /*
  * 编辑|完成按钮
  * */
  Widget _editTagWidget() {
    return _isEditBtn == true
        ? InkWell(
            onTap: () {
              setState(() {
                _isEditBtn = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '编辑    ',
                style: TextStyle(color: Color(0xFF999999)),
              ),
            ),
          )
        : InkWell(
            onTap: () async {
              setState(() {
                _isEditBtn = true;
              });
              print('点击完成');
              print(_tagList);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setStringList('TAG', _tagList);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.done,
                    color: Color(0xFF999999),
                    size: 20,
                  ),
                  Text(
                    '完成  ',
                    style: TextStyle(color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
          );
  }

  /*
  * 商品描述输入框
  * */
  Widget _productDescWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        textInputAction: TextInputAction.next,
        onSubmitted: (e) {
          _tagEditController.text = '$e ';
        },
        maxLines: 3,
        decoration: InputDecoration(
          hintText: '商品描述',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBBBBBB),
            ),
          ),
        ),
        keyboardType: TextInputType.multiline,
        controller: _tagEditController,
      ),
    );
  }
}
