/*
* 分享Dialog
* */
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../serviceapi/customerapi.dart';
import '../../utils/utils.dart';

class EditDialog extends StatefulWidget {
  String loadingText;
  bool outsideDismiss;
  Map map;
  Function dismissCallback;
  Function okCallback;
  Function otherCallback;

  EditDialog({
    Key key,
    this.loadingText = "我是自定义标题",
    this.outsideDismiss = true,
    this.dismissCallback,
    this.okCallback,
    this.otherCallback,
    this.map,
  }) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  String _radioValue = '一口价';
  String _earnings = '';
  String _min_earnings = '';
  String _max_earnings = '';
  Map back_map = {};

  bool _successTag = false;

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  _okCallback() {
    if (widget.okCallback != null) {
      widget.okCallback();
    }
    Navigator.of(context).pop();
  }

  _otherCallback() {
    if (widget.otherCallback != null) {
      widget.otherCallback();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.map);
    double price = widget.map['MyPrice'];
    double minPrice = widget.map['MyMinPrice'];
    double maxPrice = widget.map['MyMaxPrice'];

    _nameController.text = widget.map['ProductName'];

    _priceController.text = Utils.stringFormat(price.toString()) == '0'
        ? ''
        : Utils.stringFormat(price.toString());
    _minPriceController.text = Utils.stringFormat(minPrice.toString()) == '0'
        ? ''
        : Utils.stringFormat(minPrice.toString());
    _maxPriceController.text = Utils.stringFormat(maxPrice.toString()) == '0'
        ? ''
        : Utils.stringFormat(maxPrice.toString());

    double d = widget.map['VendorPrice'];

    if (price == maxPrice && price == 0.0) {
      double result = price - d;

      setState(() {
        _radioValue = '一口价';
        _earnings = Utils.stringFormat(result.toString());
      });
    } else if (maxPrice == minPrice && price != 0.0) {
      double result = price - d;

      setState(() {
        _radioValue = '一口价';
        _earnings = Utils.stringFormat(result.toString());
      });
    } else {
      double min = minPrice - d;
      double max = maxPrice - d;
      setState(() {
        _radioValue = '区间价';
        _min_earnings = Utils.stringFormat(min.toString());
        _max_earnings = Utils.stringFormat(max.toString());
      });
    }
  }

  /*
  * 上架/编辑
  * */
  _putawayAction() {
//    print(_priceController.text);
//    print(_minPriceController.text);
//    print(_maxPriceController.text);

    Map map = {
      'MyGuid': widget.map['MyGuid'],
      'MyDescription': _nameController.text,
      'VendorProductGuid': widget.map['Guid'],
      'VendorGuid': widget.map['VendorGuid'],
      'myprice':
          _priceController.text == "" ? 0 : double.parse(_priceController.text),
      'myminprice': _minPriceController.text == ""
          ? 0
          : double.parse(_minPriceController.text),
      'mymaxprice': _maxPriceController.text == ""
          ? 0
          : double.parse(_maxPriceController.text),
      'status': 1,
      'displayOnHomePage': 1,
      'displayOrder': 0,
      'confirmPriceRequired': false,
      'pictureList': widget.map['PictureList'],
      'tagList': [],
      'productName': _nameController.text,
      'description': _nameController.text,
    };
    Map map1 = {
      'status': 1,
      'productList': [map]
    };
    CustomerApi().PublishVendorProduct(context, map1).then((e) {
      if (e['Success'] == true) {
        print('成功--');
        print(e);

        setState(() {
          _successTag = true;
        });
      } else {
        print('失败');
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 300.0,
            height: 480.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                        ),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${widget.map['PictureList'][0]}'),
                            ),
                          ),
                          child: Container(
                            width: 130,
                            color: Colors.black54,
                            child: Text(
                              '  ¥ ${Utils.stringFormat(
                                widget.map['VendorPrice'].toString(),
                              )}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      _successTag == false
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: '商品名称 ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                255, 101, 101, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    width: 270,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8),
                                    color: Color.fromRGBO(243, 243, 243, 1),
                                    child: TextField(
                                      cursorColor:
                                          Color.fromRGBO(187, 187, 187, 1),
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '我的售价 ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '*',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(
                                                255, 101, 101, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      InkWell(
//                                        onTap: () {
//                                          _minPriceController.text = '';
//                                          _maxPriceController.text = '';
//                                          setState(() {
//                                            _radioValue = '一口价';
//                                            _earnings = '';
//                                          });
//                                        },
//                                        child: Row(
//                                          children: <Widget>[
//                                            _radioValue == '一口价'
//                                                ? Image.asset(
//                                                    'assets/icon_detail_add_yellow.png')
//                                                : Image.asset(
//                                                    'assets/icon_share_unchecked.png'),
//                                            Text('一口价')
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(width: 10),
//                                      InkWell(
//                                        onTap: () {
//                                          _priceController.text = '';
//                                          setState(() {
//                                            _radioValue = '区间价';
//                                            _max_earnings = '';
//                                            _min_earnings = '';
//                                          });
//                                        },
//                                        child: Row(
//                                          children: <Widget>[
//                                            _radioValue == '区间价'
//                                                ? Image.asset(
//                                                    'assets/icon_detail_add_yellow.png')
//                                                : Image.asset(
//                                                    'assets/icon_share_unchecked.png'),
//                                            Text('区间价')
//                                          ],
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  _radioValue == '一口价'
//                                      ? _buildPriceArea()
//                                      : _buildPriceSwitchArea(),
//                                  _radioValue == '一口价'
//                                      ? Text('利润 $_earnings')
//                                      : Text(
//                                      '利润 $_min_earnings ~ $_max_earnings'),

                                  _buildPriceArea(),
                                  Text('利润 ${_earnings}'),
                                  InkWell(
                                    onTap: _putawayAction,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 15, top: 30),
                                      height: 50,
                                      color: Color.fromRGBO(255, 175, 76, 1),
                                      child: Center(
                                        child: Text(
                                          '上架销售',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      'assets/icon_publish_success.png'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('商品上架成功'),
                                  Text('可到您的购物墙查看'),
                                  InkWell(
                                    onTap: widget.outsideDismiss
                                        ? _okCallback
                                        : null,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 50),
                                      height: 50,
                                      color: Color.fromRGBO(255, 175, 76, 1),
                                      child: Center(
                                        child: Text(
                                          '关闭',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[],
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: widget.outsideDismiss ? _dismissDialog : null,
                    child: Container(
                      width: 50,
                      height: 50,
//                    color: Colors.red,
                      child: Center(
                        child: Image.asset(
                          'assets/icon_grey_delete.png',
                          width: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  * 输入价格
  * */
  Widget _buildPriceArea() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(243, 243, 243, 1),
      ),
      height: 40,
      margin: EdgeInsets.only(right: 15, top: 5, bottom: 5),
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
//            color: Colors.red,
            child: TextField(
              cursorColor: Color.fromRGBO(187, 187, 187, 1),
              onChanged: (e) {
                double d = widget.map['VendorPrice'];
                double result = double.parse(e) - d;
                setState(() {
                  _earnings = result.toString();
                });
              },
              keyboardType: TextInputType.number,
              controller: _priceController,
              style: TextStyle(fontSize: 20, color: Colors.red),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 1),
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: ''),
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
      height: 34,
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(200),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  onChanged: (e) {
                    double d = widget.map['VendorPrice'];
                    double result = double.parse(e) - d;
                    setState(() {
                      _min_earnings = result.toString();
                    });
                  },
                  keyboardType: TextInputType.number,
                  controller: _minPriceController,
                ),
              ),
              Text('~'),
              Container(
                width: ScreenUtil().setWidth(200),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  onChanged: (e) {
                    double d = widget.map['VendorPrice'];
                    double result = double.parse(e) - d;
                    setState(() {
                      _max_earnings = result.toString();
                    });
                  },
                  keyboardType: TextInputType.number,
                  controller: _maxPriceController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
