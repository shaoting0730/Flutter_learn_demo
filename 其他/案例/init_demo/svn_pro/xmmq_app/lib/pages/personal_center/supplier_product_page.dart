/*
* 线上供应商-商品
* */

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; //
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../serviceapi/customerapi.dart';
import '../../models/api/supplierProduct.dart';
import '../store_main.dart';
import '../store_dynamic/publish_activity.dart';
import '../../models/api/goods.dart';
import '../../widgets/loading_widget.dart';
import '../../routers/application.dart';
import 'supplier_image_page.dart';
import '../../utils/customDialog/edit_dialog.dart';
import '../../utils/utils.dart';

class SupplierProductPage extends StatefulWidget {
  final String VendorCategoryGuid;
  final String VendorGuid;
  final Map map;
  SupplierProductPage({
    Key key,
    @required this.VendorCategoryGuid,
    @required this.VendorGuid,
    @required this.map,
  }) : super(key: key);

  @override
  _SupplierProductPageState createState() => _SupplierProductPageState();
}

class _SupplierProductPageState extends State<SupplierProductPage> {
//  Map _model;
  List _dataSource = [];
  IjkMediaController _videoController = IjkMediaController();
  int _PageIndex = 0;
  String _productName = '';

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  bool _showLoadingTag = true; //  加载中状态

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(widget.VendorCategoryGuid);
//    print(widget.VendorGuid);
    _getProductData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  /*
  * 获取线上商品数据
  * */
  _getProductData() {
    Map map = {
      "VendorCategoryGuid": "",
      'VendorGuid': widget.VendorGuid,
      "pageIndex": _PageIndex,
      "pageSize": 20,
      "productName": _productName,
    };
//    print(map);
    CustomerApi().SearchVendorProduct(context, map).then((val) {
      setState(() {
        _dataSource += val['Data']['ListObjects'];
        _showLoadingTag = false;
      });
//      print('产品数据 ---- ${jsonEncode(_model)}');
    }).catchError((error) {
      print(error);
      setState(() {
        _showLoadingTag = false;
      });
    });
  }

  /*
  *  编辑/上架 按钮 点击
  * */
  _editAction(e) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EditDialog(
          map: e,
          okCallback: () async {
            if (mounted) {
              setState(() {
                _dataSource = [];
                _PageIndex = 0;
                _showLoadingTag = true;
              });
            }
            _getProductData();
          },
          dismissCallback: () {
            print("取消了");
          },
        );
      },
    );
  }

  /*
  * 推导出价格
  * */
  String _deducePrice(price, minPrice, maxPrice) {
    if (price == maxPrice && price == 0) {
      return '¥0';
    } else if (maxPrice == minPrice && price != 0) {
      return '¥ ${Utils.stringFormat(price.toString())}';
    } else {
      return '¥${Utils.stringFormat(minPrice.toString())}-¥${Utils.stringFormat(minPrice.toString())}';
    }
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
        title: Container(
//          color: Colors.red,
          width: 200,
//          padding: EdgeInsets.only(left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  '${widget.map['Data'].last['VendorLogoUrl']}?imageView2/0/w/60/h/60',
                  width: 35,
                  height: 35,
                ),
              ),
              Text(
                '${widget.map['Data'].last['VendorName']}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                padding: EdgeInsets.only(left: 10),
                color: Color.fromRGBO(240, 240, 240, 1),
                child: CupertinoTextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  onSubmitted: (e) {
                    setState(() {
                      _productName = e;
                      _PageIndex = 0;
                      _dataSource = [];
                    });
                    _getProductData();
                  },
                  clearButtonMode: OverlayVisibilityMode.editing,
                  placeholder: '请输入搜索关键字',
                  style: TextStyle(
                      fontSize: 13, textBaseline: TextBaseline.alphabetic),
                  textInputAction: TextInputAction.search,
//                  decoration: InputDecoration(
//                    border: InputBorder.none,
//                    icon: Image.asset('assets/icon_home_search.png'),
//                    hintStyle: TextStyle(
//                      fontSize: 13,
//                      color: Color.fromRGBO(143, 143, 143, 1),
//                    ),
//                    hintText: '请输入搜索关键字',
//                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width,
                height: 15,
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              Expanded(
                child: _listWidget(),
              ),
            ],
          ),
          _showLoadingTag == true
              ? Positioned(
                  child: LoadingWidget(title: ' 加载中...'),
                )
              : Text('')
        ],
      ),
    );
  }

  Widget _listWidget() {
    return EasyRefresh(
      key: _easyRefreshKey,
      refreshHeader: ClassicsHeader(
        key: _headerKey,
        bgColor: Colors.white,
        textColor: Color.fromRGBO(102, 102, 102, 1),
        moreInfoColor: Color.fromRGBO(102, 102, 102, 1),
        showMore: true,
        moreInfo: '下拉刷新...',
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        bgColor: Colors.white,
        textColor: Color.fromRGBO(102, 102, 102, 1),
        moreInfoColor: Color.fromRGBO(102, 102, 102, 1),
        showMore: true,
        noMoreText: '',
        moreInfo: '加载中...',
        loadReadyText: '上拉加载',
      ),
      loadMore: () async {
        setState(() {
          _PageIndex++;
        });
        _getProductData();
      },
      onRefresh: () async {
        setState(() {
          _dataSource = [];
          _PageIndex = 0;
          _showLoadingTag = true;
        });
        _getProductData();
      },
      child: ListView.builder(
        itemCount: _dataSource.length,
        itemBuilder: (BuildContext context, int index) {
          return _ProductItem(index);
        },
      ),
    );
  }

  Widget _ProductItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                _dataSource[index]['PictureList'].length > 0
                    ? _dataSource[index]['PictureList'][0]
                    : '${'${_dataSource[index]['VideoUrl']}?vframe/jpg/offset/0|imageView2/1/w/400/h/200'}',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
              Container(
                width: 250,
//                color: Colors.red,
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _dataSource[index]['ProductName'],
                      style: TextStyle(color: Color.fromRGBO(255, 175, 76, 1)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '¥${Utils.stringFormat(_dataSource[index]['VendorPrice'].toString())}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(153, 153, 153, 1),
                            ),
                          ),
                          _dataSource[index]['MyGuid'].length == 0
                              ? InkWell(
                                  onTap: () => _editAction(_dataSource[index]),
                                  child: Container(
                                    width: 64,
                                    height: 33,
                                    color: Color.fromRGBO(255, 175, 76, 1),
                                    margin: EdgeInsets.only(right: 10, top: 5),
                                    child: Center(
                                      child: Text(
                                        '上架',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () => _editAction(_dataSource[index]),
                                  child: Container(
                                    width: 64,
                                    height: 33,
                                    margin: EdgeInsets.only(right: 10, top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '编辑',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    _dataSource[index]['MyGuid'].length != 0
                        ? Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  _deducePrice(
                                      _dataSource[index]['MyPrice'],
                                      _dataSource[index]['MyMinPrice'],
                                      _dataSource[index]['MyMaxPrice']),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 237, 213, 1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    '我的售价',
                                    style: TextStyle(
                                      color: Color.fromRGBO(232, 102, 31, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
