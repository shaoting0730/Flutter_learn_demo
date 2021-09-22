/*
* 动态发布
* */

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

import '../../models/api/goods.dart';
import '../../utils/utils.dart';
import 'select_product.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';

class DynamicPublish extends StatefulWidget {
  @override
  _DynamicPublishState createState() => _DynamicPublishState();
}

class _DynamicPublishState extends State<DynamicPublish> {
  final _editController = TextEditingController();
  int _publishType = 0; // 发布的类型 1 视频  2图片
  List<ListObjectsGoodsModel> _allSelectList = []; // 所有选择的图片
  List<ListObjectsGoodsModel> _selectList = []; // 选择的图片
  var num = 0;
  bool _OKbtnEnable = true;
  IjkMediaController _videoController = IjkMediaController();
  bool _playingTag = false; //  播放标识 默认未播放

  /*
  * 发布输入框
  * */
  Widget _buildTopicMessageArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Theme(
        data: ThemeData(
          primaryColor: Color.fromRGBO(187, 187, 187, 1),
        ),
        child: TextField(
          onTap: () {
            _editController.text = '#新品上架# ';
          },
          cursorColor: Color.fromRGBO(187, 187, 187, 1),
          maxLines: 6,
          decoration: InputDecoration(
            hintText: '#新品上架# 请输入...',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(220, 220, 220, 1),
                width: 0.5,
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          controller: _editController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editController.dispose();
    _videoController.dispose();
  }

  /*
  * 选择商品图片字样
  * */
  Widget _productHintWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '选择商品图片',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Image.asset('assets/icon_question_tips.png'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: <Widget>[
                Text(
//                  '已选择$num张',
                  '',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(138, 138, 138, 1),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return SelectProduct();
                        },
                      ),
                    );

                    if (result == null) {
                      return;
                    }
                    List<ListObjectsGoodsModel> list = result;
                    if (list.length == 0) {
                      return;
                    } else {
                      if (list.length == 1 && list[0].VideoUrl != null) {
                        //  视频
                        setState(() {
                          _allSelectList = list;
                          _publishType = 1;
                        });
                      } else {
                        //  图片
                        setState(() {
                          _allSelectList = list;
                          _publishType = 2;
                        });
                      }
                    }
                  },
                  child: Text(
                    '重新选择商品',
                    style: TextStyle(
                      color: Color.fromRGBO(30, 98, 182, 1),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 视频
  * */
  Widget _videoWidget() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 200, // 这里随意
            child: IjkPlayer(
              mediaController: _videoController,
            ),
          ),
          //  视频遮挡
          _playingTag == false
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _playingTag = true;
                      });
                      _videoController.play();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        '${_allSelectList[0].VideoUrl}?vframe/jpg/offset/0|imageView2/1/w/400/h/400',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Text(''),
          _playingTag == false
              ? Positioned(
                  top: 80,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _playingTag = true;
                      });
                      _videoController.play();
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
              : Text(''),
        ],
      ),
    );
  }

  /*
  * 图片
  * */
  Widget _imgsWidget() {
    List imgsList = [];
    List<Widget> imgList = [];

    _allSelectList.forEach(
      (e) {
        e.PictureList.forEach(
          (f) {
            imgList.add(
              ImgWidget(
                str: f,
                model: e,
                num: num,
              ),
            );
            setState(() {
              num++;
            });
          },
        );
      },
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: imgList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        title: Text(
          '动态发布',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildTopicMessageArea(),
                  _productHintWidget(),
                  _publishType == 0
                      ? InkWell(
                          onTap: () async {
                            final result = await Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return SelectProduct();
                                },
                              ),
                            );
                            if (result == null) {
                              return;
                            }
                            List<ListObjectsGoodsModel> list = result;
                            if (list.length == 0) {
                              return;
                            } else {
                              if (list.length == 1 &&
                                  list[0].VideoUrl != null) {
                                //  视频
                                setState(() {
                                  _allSelectList = list;
                                  _publishType = 1;
                                  _videoController.setNetworkDataSource(
                                      _allSelectList[0].VideoUrl,
                                      autoPlay: false);
                                });
                              } else {
                                //  图片
                                setState(() {
                                  _allSelectList = list;
                                  _publishType = 2;
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset('assets/xuxian.png'),
                          ),
                        )
                      : _publishType == 1 ? _videoWidget() : _imgsWidget(),
                ],
              ),
            ),
            _publishType == 0
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : InkWell(
                    onTap: () {
                      if (_OKbtnEnable == true) {
                        setState(() {
                          _OKbtnEnable = false;
                        });
                        if (_publishType == 1) {
                          print('视频');
                          _dynamicPublishActionForVideo();
                        } else if (_publishType == 2) {
                          _dynamicPublishActionForImg();
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Color.fromRGBO(253, 175, 47, 1),
                      child: Center(
                        child: Text(
                          '发 布 动 态',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /*
  *  动态发布按钮点击-图片
  * */
  _dynamicPublishActionForVideo() async {
    List PictureList = [];
    _allSelectList.forEach((e) {
      print(jsonEncode(e));
      PictureList.add({
        'ImageUrl': e.VideoUrl,
        'ProductGuid': e.Guid,
      });
    });
    Map map = {};
    map['PictureList'] = PictureList;
    map['UpdateProductsOnly'] = false;
    map['displayOrder'] = 0;
    map['productList'] = [];
    map['status'] = 1;

    var description = _editController.text;
    if (description.contains('#新品上架#')) {
      map['groupName'] = '新品上架';
      map['description'] = description.replaceAll('#新品上架#', '');
    } else {
      map['groupName'] = '';
      map['description'] = description.trim();
    }

    var response = await CustomerApi().PromoteProducts(context, map);
    if (response['Success'] == true) {
      setState(() {
        _OKbtnEnable = true;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StoreMainPage()),
          (route) => route == null);
    } else {
      setState(() {
        _OKbtnEnable = true;
      });
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "发布失败了╮(╯▽╰)╭...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  /*
  *  动态发布按钮点击-图片
  * */
  _dynamicPublishActionForImg() async {
    List PictureList = [];
    _allSelectList.forEach((e) {
      print(jsonEncode(e));
      PictureList.add({
        'ImageUrl': e.PictureList[0],
        'ProductGuid': e.Guid,
      });
    });
    Map map = {};
    map['PictureList'] = PictureList;
    map['UpdateProductsOnly'] = false;
    map['displayOrder'] = 0;
    map['productList'] = [];
    map['status'] = 1;

    var description = _editController.text;
    if (description.contains('#新品上架#')) {
      map['groupName'] = '新品上架';
      map['description'] = description.replaceAll('#新品上架#', '');
    } else {
      map['groupName'] = '';
      map['description'] = description.trim();
    }

    var response = await CustomerApi().PromoteProducts(context, map);
    if (response['Success'] == true) {
      setState(() {
        _OKbtnEnable = true;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StoreMainPage()),
          (route) => route == null);
    } else {
      setState(() {
        _OKbtnEnable = true;
      });
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "发布失败了╮(╯▽╰)╭...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }
}

class ImgWidget extends StatefulWidget {
  ListObjectsGoodsModel model;
  String str;
  int num;

  ImgWidget({Key key, this.model, this.str, this.num}) : super(key: key);

  @override
  _ImgWidgetState createState() => _ImgWidgetState();
}

class _ImgWidgetState extends State<ImgWidget> {
  bool _currentSelectType = false;
  int _productCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _productCount = widget.num;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 30 - 10 - 10) / 3;
    return InkWell(
      onTap: () {
        setState(() {
          _currentSelectType = !_currentSelectType;
        });
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.network(
              widget.str,
              width: width,
              height: width,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                color: Color.fromRGBO(0, 0, 0, 0.6),
                child: Text(
                  '${_deducePrice(widget.model.Price, widget.model.MinPrice, widget.model.MaxPrice)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                child: _currentSelectType == true
                    ? Image.asset('assets/icon_detail_add_gray.png')
                    : Image.asset('assets/icon_detail_add_yellow.png'),
              ),
            ),
//            Positioned(
//              top: 0,
//              left: 0,
//              child: _currentSelectType == true
//                  ? Text('')
//                  : Container(
//                      width: 18,
//                      height: 18,
//                      color: Color.fromRGBO(253, 175, 47, 1),
//                      child: Center(
//                        child: Text(
//                          '$_productCount',
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                    ),
//            ),
            _currentSelectType == true
                ? Positioned(
                    child: Container(
                      width: width,
                      height: width,
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
