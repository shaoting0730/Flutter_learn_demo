/*
* 店主动态- 编辑产品-视频
* */
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import '../../models/api/goods.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import 'edit_tag.dart';
import '../../utils/event_bus.dart';
import '../../utils/utils.dart';

class EditProductVideoPage extends StatefulWidget {
  final ListObjectsGoodsModel model;
  EditProductVideoPage({Key key, this.model}) : super(key: key);
  @override
  _EditProductVideoPageState createState() => _EditProductVideoPageState();
}

class _EditProductVideoPageState extends State<EditProductVideoPage> {
  var _imgRadioValue = '不定价'; // 单选按钮默认值,默认不定价
  final _priceController = TextEditingController();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _editController = TextEditingController();
  IjkMediaController _videoController = IjkMediaController();
  bool _playingTag = false; //  播放标识 默认未播放
  List _tagList = ['+ 编辑标签'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List list = widget.model.TagList;
    setState(() {
      _tagList = list + _tagList;
    });

    _editController.text = widget.model.Description;
    _deducePrice(
        widget.model.Price, widget.model.MinPrice, widget.model.MaxPrice);
    _startVideo();
  }

  /*
  * 推导出价格
  * */
  String _deducePrice(price, minPrice, maxPrice) {
    if (price == maxPrice && price == 0.0) {
      setState(() {
        _imgRadioValue = '不定价';
      });
      return '待议';
    } else if (maxPrice == minPrice && price != 0.0) {
      String str = price.toString();
      String result = Utils.stringFormat(str);

      _priceController.text = '$result';
      return '¥ $result';
    } else {
      String strMin = minPrice.toString();
      String resultMin = Utils.stringFormat(strMin);

      String strMax = maxPrice.toString();
      String resultMax = Utils.stringFormat(strMax);

      _minPriceController.text = '$resultMin';
      _maxPriceController.text = '$resultMax';

      return '¥$resultMin - ¥$resultMax';
    }
  }

  //监听Bus events
  void _listen() {
    eventBus.on<TagEvent>().listen((event) {
      Set set = event.list.toSet();
      List list = set.toList();
      for (var i = 0; i < list.length; i++) {
        if (list[i] == '') {
          list.removeAt(i);
        }
      }
//      print(list);
      if (event.num == -1) {
        if (mounted) {
          setState(() {
            _tagList = list;
          });
        }
      }
    });
  }

  /*
  * 播放视频
  * */
  _startVideo() async {
    await _videoController.setNetworkDataSource(widget.model.VideoUrl,
        autoPlay: false);
  }

  /*
  * 发布按钮点击事件
  * */
  void _handleTapPublishSuccess() async {
    _tagList.remove('+ 编辑标签');

    if (_editController.text.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "商品名不能为空~",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }

    // 发布产品
    var maxPrice = _maxPriceController.text == ""
        ? 0.0
        : double.parse(_maxPriceController.text);

    var minPrice = _minPriceController.text == ""
        ? 0.0
        : double.parse(_minPriceController.text);

    var price =
        _priceController.text == "" ? 0.0 : double.parse(_priceController.text);
    Map params = {
      "ConfirmPriceRequired": true,
      'Description': _editController.text,
      "DisplayOnHomePage": true,
      "DisplayOrder": 0,
      "FactoryVendorGuid": "",
      "Guid": widget.model.Guid,
      "MaxPrice": maxPrice,
      "Minprice": minPrice,
      "PictureList": [],
      "Price": price,
      "PriceType": 1,
      "ProductName": "",
      "RangePriceRequired": false,
      "Status": 1,
      "StoreGuid": widget.model.StoreGuid,
      "TagList": _tagList,
      "UpdatedOn": 637096358600000000,
      "VendorGuid": "",
      "VendorProductGuid": "",
      "VideoUrl": widget.model.VideoUrl
    };
    var response = await CustomerApi().UpdateDQProduct(context, params);
//    print(response);
    if (response['Success'] == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StoreMainPage()),
          (route) => route == null);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "发布失败了╮(╯▽╰)╭...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

//    Application.router.navigateTo(context, "./publish_activity_success",
//        transition: TransitionType.inFromRight);

  @override
  Widget build(BuildContext context) {
    _listen();
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
          '编辑产品',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                //视频
                Stack(
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
                              onTap: () {
                                setState(() {
                                  _playingTag = true;
                                });
                                _videoController.play();
                              },
                              child: Container(
                                child: Image.network(
                                    '${widget.model.VideoUrl}?vframe/jpg/offset/0|imageView2/1/w/400/h/200'),
                              ),
                            ),
                          )
                        : Text(''),
                    _playingTag == false
                        ? Positioned(
                            top: 80,
                            left: MediaQuery.of(context).size.width / 2 - 40,
                            child: InkWell(
                              onTap: () {
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
                // 输入条
                _someRadioWidget(),
                _imgRadioValue == '不定价'
                    ? Text('')
                    : _imgRadioValue == '一口价'
                        ? _buildPriceArea()
                        : _buildPriceSwitchArea(), // 价格区间按钮

                _historyTagWidget(), // 编辑标签
                _productDescWidget(), // 输入框
              ],
            ),
          ),
          _buildPushlishButton(),
        ],
      ),
    );
  }

  /*
  * 历史标签
  * */
  Widget _historyTagWidget() {
    if (_tagList.length > 0) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _tagList.map((childNode) {
            return GestureDetector(
              onTap: () async {
                if (childNode == '+ 编辑标签') {
                  Set set = _tagList.toSet();
                  List resultList = set.toList();

                  // 发过去,先去除 '' 和 编辑标签
                  for (var i = 0; i < resultList.length; i++) {
                    if (resultList[i] == '' || resultList[i] == '+ 编辑标签') {
                      resultList.removeAt(i);
                    }
                  }

                  await Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return EditTagPage(
                          list: resultList,
                          num: -1,
                          tag: 'video',
                        );
                      },
                    ),
                  );
                }
              },
              child: new ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Container(
                  height: 30,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: childNode == '+ 编辑标签'
                        ? Color.fromRGBO(255, 240, 221, 1)
                        : Color.fromRGBO(231, 241, 249, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    childNode,
                    style: TextStyle(
                      color: childNode == '+ 编辑标签'
                          ? Color.fromRGBO(239, 117, 29, 1)
                          : Color.fromRGBO(35, 119, 195, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Text('');
    }
  }

  /*
  * 商品名
  * */
  Widget _productDescWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 40,
        child: TextField(
          cursorColor: Color.fromRGBO(187, 187, 187, 1),
          style: TextStyle(textBaseline: TextBaseline.alphabetic),
          textInputAction: TextInputAction.next,
          onSubmitted: (e) {},
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0),
            hintText: '  商品名称',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFBBBBBB),
              ),
            ),
          ),
          keyboardType: TextInputType.multiline,
          controller: _editController,
        ),
      ),
    );
  }

/*
   * 发布按钮
   * */
  Widget _buildPushlishButton() {
    return GestureDetector(
      onTap: _handleTapPublishSuccess,
      child: Container(
        width: double.infinity,
        color: Color(0xFFFFA739),
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: SafeArea(
            child: Container(
              alignment: Alignment(0.0, 0.0),
              height: 44,
              child: Text(
                '提交修改',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  *
  * */
  Widget _someRadioWidget() {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (_imgRadioValue == '一口价') {
              setState(() {
                _imgRadioValue = '不定价';
              });
            } else {
              setState(() {
                _imgRadioValue = '一口价';
              });
            }
          },
          child: Row(
            children: <Widget>[
              _imgRadioValue == '一口价'
                  ? Image.asset('assets/icon_detail_add_yellow.png')
                  : Image.asset('assets/icon_share_unchecked.png'),
              Text('一口价')
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (_imgRadioValue == '区间价') {
              setState(() {
                _imgRadioValue = '不定价';
              });
            } else {
              setState(() {
                _imgRadioValue = '区间价';
              });
            }
          },
          child: Row(
            children: <Widget>[
              _imgRadioValue == '区间价'
                  ? Image.asset('assets/icon_detail_add_yellow.png')
                  : Image.asset('assets/icon_share_unchecked.png'),
              Text('区间价')
            ],
          ),
        ),
      ],
    );
  }

/*
  * 输入价格
  * */
  Widget _buildPriceArea() {
    return Container(
      height: 48,
      width: ScreenUtil().setWidth(480),
//      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 10),
          Text(
            "¥",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB0B0B0),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 100,
            child: TextField(
              cursorColor: Color.fromRGBO(187, 187, 187, 1),
              keyboardType: TextInputType.number,
              controller: _priceController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '输入价格'),
            ),
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
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(200),
            child: TextField(
              cursorColor: Color.fromRGBO(187, 187, 187, 1),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '输入价格',
                icon: Text(
                  '¥',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: _minPriceController,
            ),
          ),
          Text('~'),
          Container(
            width: ScreenUtil().setWidth(200),
            child: TextField(
              cursorColor: Color.fromRGBO(187, 187, 187, 1),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '输入价格',
                icon: Text(
                  '¥',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: _maxPriceController,
            ),
          ),
        ],
      ),
    );
  }
}
