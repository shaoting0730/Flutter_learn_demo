/*
* 店主动态- 编辑产品
* */
import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo/photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import 'edit_tag.dart';
import '../personal_center/supplier_image_page.dart';
import 'package:dio/dio.dart' as prefix0;
import '../../models/api/goodsGroup.dart';
import 'package:flutter/material.dart';
import '../../utils/event_bus.dart';
import 'package:http/http.dart' as prefix1;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:fluro/fluro.dart';
import '../../routers/application.dart';
import '../../models/editable_activity_item.dart';
import '../../widgets/editable_activity_item_cell.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../../models/api/goods.dart';
import '../../utils/utils.dart';

// 编辑动态页面
class EditProductPage extends StatefulWidget {
  ProductListModel model;
  EditProductPage({Key key, this.model}) : super(key: key);

  @override
  State<EditProductPage> createState() {
    return EditProductPageState();
  }
}

class EditProductPageState extends State<EditProductPage> {
  var _imgRadioValue = '不定价'; // 单选按钮默认值,默认不定价
  final _editController = TextEditingController();
  final _imgPriceController = TextEditingController();
  final _imgMaxPriceController = TextEditingController();
  final _imgMinPriceController = TextEditingController();
  List _tagList = ['+ 编辑标签'];
  List _picList = [];
  var currentSelected = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List list = widget.model.TagList;
    List imgList = widget.model.PictureList;
//    print('----------------');
//    print(widget.model.PictureList);
    setState(() {
      _picList = imgList + [];
      _tagList = list + _tagList;
    });
    _editController.text = widget.model.Description;
    _deducePrice(
        widget.model.Price, widget.model.MinPrice, widget.model.MaxPrice);

//    print('编辑产品 ${jsonEncode(widget.model)}');
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _editController.dispose();
    _imgMaxPriceController.dispose();
    _imgMinPriceController.dispose();
    _imgPriceController.dispose();
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

      _imgPriceController.text = '$result';

      setState(() {
        _imgRadioValue = '一口价';
      });
      return '¥ $result';
    } else {
      setState(() {
        _imgRadioValue = '区间价';
      });
      String strMin = minPrice.toString();
      String resultMin = Utils.stringFormat(strMin);

      String strMax = maxPrice.toString();
      String resultMax = Utils.stringFormat(strMax);

      _imgMinPriceController.text = '$resultMin';
      _imgMaxPriceController.text = '$resultMax';

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
  * 发布按钮点击事件
  * */
  void _handleTapPublishSuccess() async {
    _tagList.remove('+ 编辑标签');

    Map params = {
      "ConfirmPriceRequired": true,
      'Description': _editController.text,
      "DisplayOnHomePage": true,
      "DisplayOrder": 0,
      "FactoryVendorGuid": "",
      "Guid": widget.model.Guid,
      "MaxPrice": _imgMaxPriceController.text.length == 0
          ? 0.0
          : double.parse(_imgMaxPriceController.text),
      "Minprice": _imgMinPriceController.text.length == 0
          ? 0.0
          : double.parse(_imgMinPriceController.text),
      "PictureList": _picList,
      "Price": _imgPriceController.text.length == 0
          ? 0.0
          : double.parse(_imgPriceController.text),
      "PriceType": 1,
      "ProductName": "",
      "RangePriceRequired": false,
      "Status": 1,
      "StoreGuid": widget.model.StoreGuid,
      "TagList": _tagList,
      "UpdatedOn": 637096358600000000,
      "VendorGuid": "",
      "VendorProductGuid": "",
    };

    var response = await CustomerApi().UpdateDQProduct(context, params);
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

  /*
  * 拍照
  * */
  void openCamera() async {
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
//    print(_response);
    if (_response.data['Success'] == true) {
      var _url = _response.data['Data']['$imgName'];
      if (mounted) {
        setState(() {
          _picList.add(_url);
        });
      }
    }
  }

  /*
  * 删除动态方法-提示框
  * */
  _deleteAction(String str) {
    // 显示选择提示框
    var dialog = CupertinoAlertDialog(
      content: Text(
        "您确定删除此图片吗?",
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
//            print(str);
            setState(() {
              _picList.remove(str);
            });
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

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
          '商品编辑',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
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
                  _someRadioWidget(), // 单选框
                  _imgRadioValue == '不定价'
                      ? Text('')
                      : _imgRadioValue == '一口价'
                          ? _buildPriceArea() // 一口价输入框
                          : _buildPriceSwitchArea(), // 区间价输入框
                  _productDescWidget(), // 商品描述输入框
                  _historyTagWidget(), // 编辑标签
                  _imgWrapWidget(), // 一堆图片
                  _buildPublishEntryPointArea(), // 添加照片
                ],
              ),
            ),
            InkWell(
              onTap: _handleTapPublishSuccess,
              child: Container(
                color: Color.fromRGBO(255, 175, 76, 1),
                height: 50,
                child: Center(
                  child: Text(
                    '保 存 修 改',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
  * 一堆图片
  * */
  Widget _imgWrapWidget() {
    List<Widget> listWidget = [];
    for (var i = 0; i < _picList.length; i++) {
      if (_picList.length == 1) {
        listWidget.add(
          InkWell(
            onTap: () => this._lookGigPic(_picList[i]),
            child: Container(
              padding: EdgeInsets.only(left: 3),
              child: Image.network(
                _picList[i],
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      } else {
        listWidget.add(InkWell(
          onTap: () => this._lookGigPic(_picList[i]),
          child: Container(
            padding: EdgeInsets.only(left: 3),
            child: Stack(
              children: <Widget>[
                Image.network(
                  _picList[i],
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => this._deleteAction(_picList[i]),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Wrap(
        children: listWidget,
      ),
    );
  }

  /*
  * 点击放大
  * */
  _lookGigPic(String str) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierImagePage(imgStr: str),
      ),
    );
  }

  /*
  * 商品名
  * */
  Widget _productDescWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 40,
        child: Theme(
          data: ThemeData(
            primaryColor: Color.fromRGBO(187, 187, 187, 1),
          ),
          child: TextField(
            cursorColor: Color.fromRGBO(187, 187, 187, 1),
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            textInputAction: TextInputAction.done,
            onSubmitted: (e) {},
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0),
              hintText: ' 商品名称',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(187, 187, 187, 1),
                  width: 1,
                ),
              ),
            ),
            keyboardType: TextInputType.multiline,
            controller: _editController,
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
              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              keyboardType: TextInputType.number,
              controller: _imgPriceController,
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
      height: 34,
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(200),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
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
                  controller: _imgMinPriceController,
                ),
              ),
              Text('~'),
              Container(
                width: ScreenUtil().setWidth(200),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
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
                  controller: _imgMaxPriceController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /*
  * 选择图片按钮 + 底部文字
  * */
  Widget _buildPublishEntryPointArea() {
    return _picList.length == 9
        ? Text('')
        : Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTakePictureArea(), // 选择图片按钮
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    '*图片还能添加${9 - _picList.length}张',
                    style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                  ),
                )
              ],
            ),
          );
  }

  /*
  * 选择图片按钮
  * */
  Widget _buildTakePictureArea() {
    return GestureDetector(
      onTap: _onTapAddPicture,
      child: Container(
        color: Color(0xFFF0F0F0),
        height: 109,
        width: 109,
        child: Center(
          child: Image.asset('assets/icon_publish_picture_add.png'),
        ),
      ),
    );
  }

  /*
  * 选择图片按钮点击事件
  * */
  void _onTapAddPicture() {
    _optionsDialogBox().then((v) => {});
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
                    onTap: openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('从相册选择'),
                    onTap: () => this._pickAsset(PickType.onlyImage),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _pickAsset(PickType type, {List<AssetPathEntity> pathList}) async {
    Navigator.of(context).pop();

    List<AssetEntity> imgList = await PhotoPicker.pickAsset(
      // BuildContext required
      context: context,

      /// The following are optional parameters.
      themeColor: Colors.black,
      // the title color and bottom color

      textColor: Colors.white,
      // text color
      padding: 1.0,
      // item padding
      dividerColor: Color(0xFF999999),
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected: 9 - _picList.length,
      // max picker image count
      // provider: I18nProvider.english,
      provider: I18nProvider.chinese,
      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 3,
      // item row count

      thumbSize: 150,
      // preview thumb size , default is 64
      sortDelegate: SortDelegate.common,
      // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Colors.white,
//        checkColor: Colors.green,
      ),
      // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

      // if you want to build custom loading widget,extends LoadingDelegate, [see example/lib/main.dart]

      badgeDelegate: const DurationBadgeDelegate(),
      // badgeDelegate to show badge widget

      pickType: type,

      photoPathList: pathList,
    );

    if (imgList == null) {
      currentSelected = "not select item";
    } else {
      List<String> r = []; // img 真实路径数组
      for (var e in imgList) {
        var file = await e.file;
        _uploadImg(EditableActivityItem(thumbnail: file.absolute.path));
      }
    }

    setState(() {});
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
}
