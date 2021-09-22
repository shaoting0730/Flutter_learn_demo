/*
* 首页-搜索栏
* */
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/event_bus.dart';
//typedef SearchBarFilterPressCallback = void Function();

class SearchBar extends StatefulWidget {
  Function onFilterPressed;
  Function onSelectPressed;
  Function inputBack;

  bool selectTag = false;
  bool needSelectTag = false;
  SearchBar({
    Key key,
    this.onFilterPressed,
    this.onSelectPressed,
    this.inputBack(String result),
    this.selectTag,
    this.needSelectTag,
  }) : super(key: key);

  @override
  State<SearchBar> createState() {
    return SearchBarState();
  }
}

class SearchBarState extends State<SearchBar> {
  final _editController = TextEditingController();

  //监听Bus events
  void _listen() {
    eventBus.on<InputValue>().listen((event) {
      _editController.text = event.str;
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: <Widget>[
          _buildSearchTextArea(),
          _createFilterArea(),
          widget.needSelectTag == true ? _selectArea() : Text(''),
        ],
      ),
    );
  }

  Widget _selectArea() {
    return Container(
      child: InkWell(
        onTap: () {
          widget.onSelectPressed();
        },
        child: Text(widget.selectTag == true ? '取消选择' : '选择'),
      ),
    );
  }

  Widget _createFilterArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: GestureDetector(
        onTap: () {
          print('开始搜索');
          widget.onFilterPressed();
        },
        child: Row(
          children: <Widget>[
            Container(
                child: Image.asset('assets/icon_home_screen_gray.png'),
                height: 15,
                width: 15),
            SizedBox(width: 5),
            Text(
              '筛选',
              style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextArea() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF3F3F3),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Center(
          child: CupertinoTextField(
            controller: _editController,
            onChanged: (e) {
              eventBus.fire(new InputValue(e)); // 先发
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            placeholder: '请输入搜索关键字',
            cursorColor: Color.fromRGBO(187, 187, 187, 1),
            style:
                TextStyle(fontSize: 13, textBaseline: TextBaseline.alphabetic),
            prefix: Image.asset('assets/icon_home_search.png'),
//            decoration: BoxDecoration(
//                image: DecorationImage(
//              image: ExactAssetImage('assets/icon_home_search.png'),
//            )
//              hintStyle: TextStyle(fontSize: 13),
//              icon: Image.asset('assets/icon_home_search.png'),
//              fillColor: Colors.blue.shade100,
//              border: InputBorder.none,
//              contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                ),
            onSubmitted: (e) {
              widget.inputBack(e);
            },
          ),
        ),
      ),
    );
  }
}
