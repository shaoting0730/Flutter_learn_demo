/*
* 购物墙-查看产品页
* */

import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter/services.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../store_dynamic/edit_product_page.dart';
import '../../utils/utils.dart';
import '../../models/api/goods.dart';
import '../../models/api/goodsGroup.dart';
import '../store_dynamic/edit_video_page.dart';
import '../store_dynamic/edit_product_video_page.dart';
import '../../models/api/customer.dart';

class LookProductPage extends StatefulWidget {
  final ListObjectsGoodsModel model;
  final StoreInfoModel storeModel;
  final List<ListObjectsGoodsModel> list;
  final String price;
  final int index;
  LookProductPage({
    Key key,
    @required this.model,
    @required this.storeModel,
    @required this.price,
    @required this.list,
    this.index,
  }) : super(key: key);

  @override
  _LookProductPageState createState() => _LookProductPageState();
}

class _LookProductPageState extends State<LookProductPage> {
  var _pageController = new PageController(initialPage: 0);
//  IjkMediaController _videoController = IjkMediaController();
//  bool _playingTag = false; //  播放标识 默认未播放

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
  _editAction(ListObjectsGoodsModel model) {
    if (model.PictureList.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProductVideoPage(model: model),
        ),
      );
    } else {
      //    print(model.PictureList);
      Map<String, dynamic> map = {};
      map['Guid'] = model.Guid;
      map['StoreGuid'] = model.StoreGuid;
      map['FactoryVendorGuid'] = model.FactoryVendorGuid;
      map['ProductName'] = model.ProductName;
      map['Description'] = model.Description;
      map['VendorProductGuid'] = model.VendorProductGuid;
      map['Price'] = model.Price;
      map['ConfirmPriceRequired'] = model.ConfirmPriceRequired;
      map['RangePriceRequired'] = model.RangePriceRequired;
      map['MinPrice'] = model.MinPrice;
      map['MaxPrice'] = model.MaxPrice;
      map['Status'] = model.Status;
      map['DisplayOnHomePage'] = model.DisplayOnHomePage;
      map['DisplayOrder'] = model.DisplayOrder;
      map['PictureList'] = model.PictureList;
      map['VideoUrl'] = model.VideoUrl;
      map['TagList'] = model.TagList;
      map['UpdatedOn'] = model.UpdatedOn;
      ProductListModel model_result = ProductListModel.fromJson(map);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProductPage(model: model_result),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startVideo();

//    print(jsonEncode(widget.model));

    Future.delayed(Duration(milliseconds: 10)).then((e) {
      _pageController.animateToPage(widget.index,
          duration: const Duration(milliseconds: 2), curve: Curves.ease);
    });
  }

  /*
  * 播放视频
  * */
  _startVideo() async {
//    widget.list.forEach((e) async {
//      if (e.PictureList.length == 0) {
//        await _videoController.setNetworkDataSource(e.VideoUrl,
//            autoPlay: false);
//      }
//    });
  }

  /*
  * 图片
  * */
  _imgsWidget(List imgs) {
    List<Widget> _listWidget;
    imgs.map((e) {
      return _listWidget.add(
        Image.network(
          e,
          width: MediaQuery.of(context).size.width,
        ),
      );
    }).toList();
    return PageView(
      children: _listWidget,
    );
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
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, j) {
          return Stack(
            children: <Widget>[
              widget.list[j].PictureList.length == 0
                  ? EditVideoPage(
                      isWallTag: true,
                      videoUrl: widget.list[j].VideoUrl,
                      price: _deducePrice(widget.list[j].Price,
                          widget.list[j].MinPrice, widget.list[j].MaxPrice),
                      model: widget.list[j])
                  : Center(
                      child: Image.network(
                        widget.list[j].PictureList[0],
                        width: MediaQuery.of(context).size.width,
                      ),
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
                          if (widget.list[j].Description.length > 0) {
                            Clipboard.setData(ClipboardData(
                                text: widget.list[j].Description));
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
                            '${widget.list[j].Description}',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
//                  价位
                          Expanded(
                            child: Container(
                              child: Text(
                                '${_deducePrice(widget.list[j].Price, widget.list[j].MinPrice, widget.list[j].MaxPrice)}',
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
                              _editBtnWidget(j),
                              //                下架
                              _soldOutWidget(j),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _tagWidget(j),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: widget.list.length,
      ),
    );
  }

  /*
  * 标签页面
  * */
  Widget _tagWidget(index) {
    List list = widget.list[index].TagList;
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
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList();
      return Wrap(spacing: 8.0, runSpacing: 8.0, children: list_widget);
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
              onPressed: () => this._delete(widget.list[index].Guid),
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
        margin: EdgeInsets.only(left: 8),
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
      onTap: () => this._editAction(widget.list[index]),
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
