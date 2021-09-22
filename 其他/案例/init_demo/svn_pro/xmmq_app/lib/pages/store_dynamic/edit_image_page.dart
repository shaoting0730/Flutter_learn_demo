/*
* 店主动态- 编辑我的图片 1级
* */
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/api/goodsGroup.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import 'edit_product_page.dart';
import '../../utils/utils.dart';
import '../../models/api/customer.dart';

class EditImagePage extends StatefulWidget {
  final ListObjectsModel model;
  final StoreInfoModel storeModel;
  final List<ListObjectsModel> list;
  final String price;
  final int index;
  EditImagePage({
    Key key,
    @required this.model,
    @required this.storeModel,
    @required this.price,
    @required this.list,
    this.index,
  }) : super(key: key);
  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var _pageController = new PageController(initialPage: 0);

  /*
  * 推导出价格
  * */
  String _deducePrice(price, minPrice, maxPrice) {
    if (price == maxPrice && price == 0.0) {
      return '待议';
    } else if (maxPrice == minPrice && price != 0.0) {
      String str = price.toString();
      String result = Utils.stringFormat(str);
      return '¥ $result';
    } else {
      String strMin = minPrice.toString();
      String resultMin = Utils.stringFormat(strMin);

      String strMax = maxPrice.toString();
      String resultMax = Utils.stringFormat(strMax);

      return '¥$resultMin - ¥$resultMax';
    }
  }

  /*
  * 下架请求
  * */
  _delete(String guid) {
    var paramsList = [];
    paramsList.add(guid);
    CustomerApi().RemoveDQProduct(context, paramsList).then((e) {
      if (e['Success'] == true) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "下架成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => StoreMainPage()),
            (route) => route == null);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "下架失败,请稍后再试!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    }).catchError((error) {
      print(error);
    });
  }

  /*
  * 编辑方法
  * */
  _editAction(ProductListModel model) {
    print(1111);
    print(jsonEncode(model));
    print(1111);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(model: model),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print('我的所有产品--${jsonEncode(widget.list)}');
//    print('我的当前产品--${jsonEncode(widget.storeModel)}');

    Future.delayed(Duration(milliseconds: 10)).then((e) {
      _pageController.animateToPage(widget.index,
          duration: const Duration(milliseconds: 2), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 52, 52, 1),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        centerTitle: true,
        title: Text(
          '${widget.storeModel.StoreName}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: PageView.custom(
        controller: _pageController,
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return Stack(
            children: <Widget>[
              PageView.builder(
                itemBuilder: (context, j) {
                  return Image.network(
                    widget.model.ProductList[index].PictureList[j],
                    width: MediaQuery.of(context).size.width,
                  );
                },
                itemCount: widget.model.ProductList[index].PictureList.length,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 145,
                  child: ListView(
                    children: <Widget>[
                      InkWell(
                        onLongPress: () {
                          if (widget
                                  .model.ProductList[index].Description.length >
                              0) {
                            Clipboard.setData(ClipboardData(
                                text: widget
                                    .model.ProductList[index].Description));
                            Fluttertoast.showToast(
                                backgroundColor: Color(0xFF666666),
                                msg: "商品名已经复制",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 30, bottom: 15, top: 5),
                          child: Text(
                            '${widget.model.ProductList[index].Description}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
//                  价位
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                '${_deducePrice(widget.model.ProductList[index].Price, widget.model.ProductList[index].MinPrice, widget.model.ProductList[index].MaxPrice)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 175, 76, 1),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              //                编辑
                              _editBtnWidget(index),
                              //                下架
                              _soldOutWidget(index),
                            ],
                          )
                        ],
                      ),
                      _tagWidget(index),
                    ],
                  ),
                ),
              ),
            ],
          );
        }, childCount: widget.model.ProductList.length),
      ),
    );
  }

  /*
  * 标签页面
  * */
  Widget _tagWidget(index) {
    List list = widget.model.ProductList[index].TagList;
    if (list.length > 0) {
      List<Widget> list_widget = list.map((e) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: Container(
            height: 30,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(251, 240, 221, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        );
      }).toList();
      return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Wrap(spacing: 8.0, runSpacing: 8.0, children: list_widget),
      );
    } else {
      return Text('');
    }
  }

  /*
  * 下架按钮
  * */
  Widget _soldOutWidget(index) {
    return InkWell(
      onTap: () {
        // 显示选择提示框
        var dialog = CupertinoAlertDialog(
          content: Text(
            "您确定删除此内容吗?",
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text("确定"),
              onPressed: () =>
                  this._delete(widget.model.ProductList[index].Guid),
            ),
          ],
        );

        showDialog(context: context, builder: (_) => dialog);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 175, 76, 1),
        ),
        width: 78,
        height: 30,
        margin: EdgeInsets.only(left: 8, right: 30),
        child: Center(
          child: Text(
            '下架',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }

  /*
  * 编辑按钮
  * */
  Widget _editBtnWidget(index) {
    return InkWell(
      onTap: () => this._editAction(widget.model.ProductList[index]),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 175, 76, 1),
        ),
        width: 78,
        height: 30,
        child: Center(
          child: Text(
            '编辑',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
