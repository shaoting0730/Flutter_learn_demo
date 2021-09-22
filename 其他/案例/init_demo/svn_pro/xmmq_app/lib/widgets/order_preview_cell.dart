import 'dart:convert';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:core';
import 'package:dio/dio.dart';

import '../models/Enums.dart';
import '../models/api/order.dart';
import '../pages/personal_center/order_detail.dart';
import '../utils/utils.dart';
import '../utils/event_bus.dart';
import '../models/editable_activity_item.dart';
import '../serviceapi/customerapi.dart';

class OrderPreviewCell extends StatefulWidget {
  final OrderInfo orderInfo;
  final List<OrderItems> orderItems;
  final List<OrderAttributes> orderAttributes;
  final bool checkTag;
  final Function backOrder;
  final Function deleteAction;

  OrderPreviewCell({
    this.orderInfo,
    this.orderItems,
    this.orderAttributes,
    this.checkTag,
    this.backOrder(OrderInfo orderInfo, List<OrderItems> orderItems, bool type),
    this.deleteAction(OrderInfo orderInfo, List<OrderItems> orderItems),
  });

  @override
  State<OrderPreviewCell> createState() {
    return OrderPreviewCellState();
  }
}

class OrderPreviewCellState extends State<OrderPreviewCell>
    with AutomaticKeepAliveClientMixin {
  bool _selectTag = false;
  String _img_url = ''; // 物流面单
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 设置物流面单
    if (widget.orderAttributes.length > 0) {
      var str = widget.orderAttributes[0].noteValue;
      setState(() {
        _img_url = str;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  //监听Bus events
  void _listen() {
    eventBus.on<OrderAllSelect>().listen((event) {
      if (mounted) {
        if (event.tag == true) {
//          widget.backOrder(widget.orderInfo, widget.orderItems, true);
        } else {}

        setState(() {
          _selectTag = event.tag;
        });
      }
    });
  }

  /*
  * 选择图片按钮点击事件
  * */
  void _onTapAddPicture() {
    _optionsDialogBox().then((v) => {});
  }

  /*
  * 拍照
  * */
  void _openCamera() async {
    Navigator.of(context).pop();
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: picture.path));
    }
  }

  /*
  * 得到图片就上传 单张
  * */
  _uploadImg(EditableActivityItem e) async {
    int nIndex = e.thumbnail.lastIndexOf("/");
    var imgName = e.thumbnail.substring(nIndex + 1);

    ///nowDateMilliseconds.toString();
    // 上传图片
    Response _response;
    Dio dio = Dio();
    File img_file = File(e.thumbnail);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(img_file.path, filename: '$imgName'),
    });
    var url =
        'https://content.xiaomaimaiquan.com/api/v2b/Content/UploadImageFiles';
    _response = await dio.post(url,
        options: Options(headers: {
          "wbhost": CustomerApi().getStoreHost(),
          "StoreGuid": CustomerApi().getStoreGuid(),
          "token": CustomerApi().getToken(),
          "Platform": "app",
        }),
        data: formData);
    if (_response.data['Success'] == true) {
      var img = _response.data['Data']['$imgName'];
      setState(() {
        _img_url = img;
      });
      Map map = {
        'ImageUrl': img,
        'OrderGuid': widget.orderInfo.guid,
        'OrderImageType': 1,
        'StoreCustomerGuid': widget.orderInfo.storeCustomerGuid,
      };
      // 继续上传服务器
      CustomerApi().UpdateOrderImage(context, map).then((e) {
        if (e['Success'] == true) {
          print('ok');
        }
      }).catchError((error) {
        print(error);
      });
    }
  }

  /*
  * 打开相册
  * */
  void _openGallery() async {
    Navigator.of(context).pop();
    var gallery = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (gallery != null) {
      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: gallery.path));
    }
  }

  /*
  * 选择相册对话框
  * */
  Future<void> _optionsDialogBox() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('相机拍照'),
                  onTap: _openCamera,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('从相册选择'),
                  onTap: _openGallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /*
  *
  * */
  String _elicitStatusTxt(OrderInfo orderinfo) {
//    print(orderinfo.orderStatusCategory);
    if (orderinfo.orderStatusCategory == 'WaitAction') {
      return '等待卖家确认';
    } else if (orderinfo.orderStatusCategory == 'ReadyForShip') {
      return '已支付';
    } else if (orderinfo.orderStatusCategory == 'Received') {
      return '已签收';
    } else if (orderinfo.orderStatusCategory == 'Refund') {
      return '退款/售后服务';
    } else if (orderinfo.orderStatusCategory == 'Shipped') {
      return '已发货';
    } else if (orderinfo.orderStatusCategory == 'Packing') {
      return '打包中';
    }
    {
      return '未付款';
    }
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xFFF1F1F1),
      child: Column(
        children: <Widget>[
          _buildHeadArea(context),
          _buildProductThumbnailListArea(),
          _buildSummaryArea(),
          _buildSeparator(),
          _shopAndNameWidget(),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      color: Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Divider(
        color: Color(0xFFDDDDDD),
        height: 0.5,
      ),
    );
  }

  Widget _shopAndNameWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: '供货店铺：',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF999999),
              ),
              children: [
                TextSpan(
                  text: ' ${widget.orderInfo.vendorName}',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                '下单人：',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF999999),
                ),
              ),
              ClipOval(
                child: Image.network(
                  '${widget.orderInfo.wechatThumberUrl}',
                  width: 20.0,
                  height: 20.0,
                ),
              ),
              Text(
                ' ${widget.orderInfo.wechatNickName}',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF999999),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSummaryArea() {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return OrderDetails(
                orderInfo: widget.orderInfo,
                orderItems: widget.orderItems,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        color: Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '订单号：${widget.orderInfo.referenceOrderGuid}',
              style: TextStyle(
                color: Color(0xFF999999),
              ),
            ),
            Row(
              children: <Widget>[
                Text("共${widget.orderItems.length}件商品  实付  ",
                    style: TextStyle(fontSize: 13, color: Color(0xFF999999))),
                Container(
                  height: 60,
                  width: 57,
                  margin: EdgeInsets.only(right: 0),
                  child: Center(
                    child: Text(
                      "¥${widget.orderInfo.orderTotal}",
                      softWrap: true,
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadArea(BuildContext context) {
//    print(widget.orderInfo.orderStatus);
    var date = widget.orderInfo.createdOn;
    var text =
        DateFormat('yyyy-MM-dd HH:mm').format(Utils.fromAspDateTimeTicks(date));

    return Container(
      color: Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(0, 18.5, 15, 15.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.checkTag == true
              ? Checkbox(
                  value: _selectTag,
                  onChanged: (bool value) {
                    widget.backOrder(
                        widget.orderInfo, widget.orderItems, value);
                    setState(() {
                      _selectTag = value;
                    });
                  },
                )
              : Text(''),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: widget.checkTag == true ? 0 : 10),
              child: Text(
                "$text",
                style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
              ),
            ),
          ),
          Text(
            _elicitStatusTxt(widget.orderInfo),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
          ),
          widget.orderInfo.orderStatus == '等候付款' ||
                  widget.orderInfo.orderStatus == '未支付' ||
                  widget.orderInfo.orderStatus == '等待卖家确认'
              ? InkWell(
                  onTap: () {
                    var dialog = CupertinoAlertDialog(
                      content: Text(
                        "您确定删除此订单吗?",
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
                          onPressed: () {
                            widget.deleteAction(
                                widget.orderInfo, widget.orderItems);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );

                    showDialog(context: context, builder: (_) => dialog);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/icon_address_delete.png',
                            width: 15,
                          ),
                          Text(
                            ' 删除',
                            style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Text(''),
          widget.orderInfo.orderStatus == '包裹已寄出'
              ? InkWell(
                  onTap: _onTapAddPicture,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/icon_advertisement_upload.png',
                          width: 15,
                        ),
                        Text(
                          '上传物流单',
                          style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  Widget _buildProductThumbnailListArea() {
    return InkWell(
      onTap: () async {
//        print(widget.orderInfo);
//        print(widget.orderItems);
        await Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return OrderDetails(
                orderInfo: widget.orderInfo,
                orderItems: widget.orderItems,
              );
            },
          ),
        );
      },
      child: Container(
        color: Color(0xFFF1F1F1),
        width: double.infinity,
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.orderItems.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildProductOverviewItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildProductOverviewItem(int index) {
    if (_img_url.length > 0 && index == 0) {
      return Row(
        children: <Widget>[
          Container(
            height: 75,
            width: 75,
            margin: EdgeInsets.only(left: 7, top: 7, bottom: 7),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_img_url),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment(0.0, 0.0),
              child: Text('发货面单',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0)),
              height: 18,
              color: Color(0x99000000),
            ),
          ),
          Container(
            height: 75,
            width: 75,
            margin: EdgeInsets.only(left: 7, top: 7, bottom: 7),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.orderItems[index].productImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: widget.orderItems[index].subTotal.toInt() != 0
                ? Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 50,
                      ),
                      child: Text(
                        '¥${widget.orderItems[index].subTotal.toInt()}',
                        style:
                            TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                    color: Color(0x99000000),
                  )
                : Text(''),
          )
        ],
      );
    } else {
      return Container(
        height: 120,
        width: 120,
        margin: EdgeInsets.only(left: 7, top: 7, bottom: 7),
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.orderItems[index].productImageUrl + ''),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.orderItems[index].subTotal.toInt() != 0
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 50),
                  child: Text(
                    '¥${widget.orderItems[index].subTotal.toInt()}',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.0,
                    ),
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
                color: Color(0x99000000),
              )
            : Text(
                '待议',
                style: TextStyle(color: Colors.white),
              ),
      );
    }
  }
}
