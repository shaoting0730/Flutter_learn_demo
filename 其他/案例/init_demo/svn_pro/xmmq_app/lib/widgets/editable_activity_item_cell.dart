import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditableActivityItemCell extends StatefulWidget {
  final String thumbnail;

  EditableActivityItemCell({this.thumbnail});

  @override
  State<StatefulWidget> createState() {
    return EditableActivityItemCellState();
  }
}

class EditableActivityItemCellState extends State<EditableActivityItemCell> {
  bool _switchBoll = false; // 区间按钮开关状态
  final _price_controller = TextEditingController(); // 输入框控制器
  final _minprice_controller = TextEditingController(); // 输入框控制器
  final _maxprice_controller = TextEditingController(); // 输入框控制器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('thumbnail 是 ${widget.thumbnail}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // 照片UI一栏
          _buildThumbnailAndPriceArea(),
          SizedBox(height: 5),
          // 上方的输入框
          _buildGoodTopicDescription()
        ],
      ),
    );
  }

  /*
  * 上方的输入框
  * */
  Widget _buildGoodTopicDescription() {
    return Container(
        child: TextField(
      cursorColor: Color.fromRGBO(187, 187, 187, 1),
      maxLines: 3,
      decoration: InputDecoration(
          hintText: '#添加话题# 这是一条已经编辑过的商品描述',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBBBBBB)))),
      keyboardType: TextInputType.multiline,
    ));
  }

  Widget _buildThumbnailAndPriceArea() {
    return Container(
        child: Row(
      children: <Widget>[
        // 图片
        Image.file(File(widget.thumbnail),
            height: 109, width: 109, fit: BoxFit.cover),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // 价格区间按钮
              _buildPriceSwitchArea(),
              // 输入价格
              _buildPriceArea(),
              // 分享时隐藏按钮
              _buildShareArea()
            ],
          ),
        )
      ],
    ));
  }

  /*
 * 分享时隐藏按钮
 * */
  Widget _buildShareArea() {
    return Container(
      width: 200,
      height: 40,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            onChanged: (bool value) {
              setState(() {});
            },
          ),
          Text(
            '分享时隐藏商品价格',
            style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
          )
        ],
      ),
    );
  }

  /*
  * 输入价格
  * */
  Widget _buildPriceArea() {
    return Container(
      height: 48,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text("¥",
                  style: TextStyle(fontSize: 18, color: Color(0xFFB0B0B0))),
              SizedBox(width: 10),
              Container(
                width: 100,
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  keyboardType: TextInputType.number,
                  enabled: !_switchBoll,
                  controller: _price_controller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '输入价格'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /*
  * 价格区间按钮
  * */
  Widget _buildPriceSwitchArea() {
    return Container(
      height: 34,
      child: Row(
        children: <Widget>[
          Switch(
            value: _switchBoll,
            onChanged: (bool value) {
              if (value == true) {
                // 锁死输入框
                _price_controller.text = '';
              }
              setState(() {
                _switchBoll = value;
              });
            },
          ),
          _switchBoll == true
              ? Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(120),
                      child: TextField(
                        cursorColor: Color.fromRGBO(187, 187, 187, 1),
                        keyboardType: TextInputType.number,
                        controller: _minprice_controller,
                      ),
                    ),
                    Text('~'),
                    Container(
                      width: ScreenUtil().setWidth(120),
                      child: TextField(
                        cursorColor: Color.fromRGBO(187, 187, 187, 1),
                        keyboardType: TextInputType.number,
                        controller: _minprice_controller,
                      ),
                    ),
                  ],
                )
              : Text(
                  '区间定价',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                )
        ],
      ),
    );
  }
}
