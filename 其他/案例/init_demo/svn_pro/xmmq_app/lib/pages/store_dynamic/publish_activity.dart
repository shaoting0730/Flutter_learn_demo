/*
* 发布页面
* */
import 'dart:convert';
import 'dart:core';
import 'dart:core' as prefix2;
import 'dart:ffi';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:dio/dio.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as prefix1;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';
import 'dart:io';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:fluro/fluro.dart';
import '../../routers/application.dart';
import '../../models/editable_activity_item.dart';
import '../../widgets/editable_activity_item_cell.dart';
import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../../models/api/goods.dart';
import '../../routers/application.dart';
import 'edit_tag.dart';
import '../../utils/event_bus.dart';
import '../../widgets/loading_widget.dart';

// 发布动态页面
class PublishActivity extends StatefulWidget {
  List<ListObjectsGoodsModel> list;
  bool shoppingWallRag;
  PublishActivity({Key key, this.list, this.shoppingWallRag}) : super(key: key);

  @override
  State<PublishActivity> createState() {
    return PublishActivityState();
  }
}

class PublishActivityState extends State<PublishActivity> {
  final _editController = TextEditingController();
  final _videoPriceController = TextEditingController();
  final _videoMaxPriceController = TextEditingController();
  final _videoMinPriceController = TextEditingController();
  final _videoNameController = TextEditingController();
  final _flutterVideoCompress = FlutterVideoCompress();
  final int _maximumFileSize = 2 * 1024 * 1024;
  bool _showLoadingTag = false; //  加载中状态
  int _uploadImgConunt = 0; //   上传图片的张数
  int _uploadImgSuccess = 0; //   成功的次数

  bool _OKbtnEnable = true;

  List<String> _videoTagList = ['+ 编辑标签'];

  IjkMediaController _videoController = IjkMediaController();

  List<Map> _imgControList = []; // 控制器数组&控制状态 图片
  List<Map> _videoControList = []; // 控制器数组&控制状态  视频

  var _imgRadioValue = '一口价'; // 单选按钮默认值

  var items = List<EditableActivityItem>();

  var currentSelected = '';

  bool _playingTag = false; //  播放标识 默认未播放
  bool _allApply = false; // 应用于所有

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(jsonEncode(widget.list));

    _initImgAndVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoNameController.dispose();
    _editController.dispose();
    _videoController.dispose();
    _videoMinPriceController.dispose();
    _videoPriceController.dispose();
    _videoMaxPriceController.dispose();
  }

  _initImgAndVideo() async {
    if (widget.list != null) {
//      _editController.text = widget.list[0].ProductName;
      widget.list.forEach((e) {
        e.PictureList.forEach((val) {
          var priceCon = TextEditingController();
          var minpriceCon = TextEditingController();
          var maxpriceCon = TextEditingController();
          var descCon = TextEditingController();
          List<String> tagList = [];
          priceCon.text = e.Price.toString();
          minpriceCon.text = e.MinPrice.toString();
          maxpriceCon.text = e.MaxPrice.toString();
          descCon.text = e.Description == null ? '' : e.Description.toString();

          if (e.TagList != null && e.TagList.length > 0) {
            e.TagList.forEach((e) {
              tagList.add(e);
            });
          }

          if (e.TagList != null && e.TagList.length < 5) {
            tagList.add('+ 编辑标签');
          }
          if (e.TagList == null) {
            tagList = [];
            tagList.add('+ 编辑标签');
          }

          String tag = '0';
          if (e.MinPrice != 0 && e.MaxPrice != 0) {
            tag = '2';
          } else if (e.Price != 0) {
            tag = '1';
          }
          setState(() {
            _imgControList.add({
              'tag': tag,
              'price': priceCon,
              'minprice': minpriceCon,
              'maxprice': maxpriceCon,
              'descCon': descCon,
              'imgurl': val,
              'tagList': tagList,
              'checkTag': false,
              'radioValue': '一口价'
            });
          });
        });

        if (widget.list[0].VideoUrl != null &&
            widget.list[0].VideoUrl.length > 0) {
          _videoController.setNetworkDataSource(widget.list[0].VideoUrl,
              autoPlay: false);

          _videoMaxPriceController.text = widget.list[0].MaxPrice.toString();
          _videoMinPriceController.text = widget.list[0].MinPrice.toString();

          _videoNameController.text = widget.list[0].Description == null
              ? ''
              : widget.list[0].Description.toString();

          _videoPriceController.text = widget.list[0].Price.toString();

          String tag = '0';
          if (e.MinPrice != 0 && e.MaxPrice != 0) {
            tag = '2';
          } else if (e.Price != 0) {
            tag = '1';
          }

          List<String> tagList = [];

          if (widget.list[0].TagList != null &&
              widget.list[0].TagList.length < 5) {
            tagList.add('+ 编辑标签');
          }
          if (widget.list[0].TagList != null &&
              widget.list[0].TagList.length > 0) {
            widget.list[0].TagList.forEach((e) {
              tagList.add(e);
            });
          }

          setState(() {
            _videoTagList = tagList;
            _videoControList.add({
              'tag': '0',
              'price': _videoPriceController,
              'minprice': _videoMinPriceController,
              'maxprice': _videoMaxPriceController,
              'descCon': _videoNameController,
              'tagList': tagList,
              'videourl': widget.list[0].VideoUrl,
            });
          });
        }
      });
    }
  }

  //监听Bus events
  void _listen() {
    eventBus.on<TagEvent>().listen((event) {
      Set set = event.list.toSet();
      List<String> list = set.toList();
      for (var i = 0; i < list.length; i++) {
        if (list[i] == '') {
          list.removeAt(i);
        }
      }
      if (event.num == -1) {
        if (mounted) {
          setState(() {
            _videoTagList = list;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _imgControList[event.num]['tagList'] = list;
          });
        }

        if (_allApply == true) {
          _imgControList.forEach((e) {
            e['tagList'] = list;
          });
        }
      }
    });

    eventBus.on<ProductName>().listen((event) {
      if (_allApply == true) {
        _imgControList.forEach((e) {
          e['descCon'].text = event.str;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
            widget.shoppingWallRag == true ? '批量上传' : '发布动态',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
                    // 主体布局
                    _buildEditableActivityItems(),
                    SizedBox(height: 15),
                    _buildPushlishButton()
                  ],
                ),
              ),
              _showLoadingTag == true
                  ? Positioned(
                      child: LoadingWidget(title: '上传中...'),
                    )
                  : Text('')
            ],
          ),
        ));
  }

  /*
   * 发布按钮 _showLoadingTag
   * */
  Widget _buildPushlishButton() {
    return GestureDetector(
      onTap: () {
        if (_OKbtnEnable == true) {
          setState(() {
            _OKbtnEnable = false;
          });
          if (_imgControList.length > 0) {
            // 发布图片
            _handleTapPublishPictureSuccess();
          } else if (_videoControList.length == 1) {
            // 发布视频
            _handleTapPublishVideoSuccess();
          } else {
            setState(() {
              _OKbtnEnable = true;
            });
            Fluttertoast.showToast(
                backgroundColor: Color(0xFF666666),
                msg: "请至少选择一个视频或者图片",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER);
          }
        }
      },
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
                widget.shoppingWallRag == true ? '批量上传' : '发布动态',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          cursorColor: Color.fromRGBO(187, 187, 187, 1),
          maxLines: 6,
          decoration: InputDecoration(
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

  Widget _buildThumbnailAndPriceArea(int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 图片
              Image.network(
                _imgControList[index]['imgurl'] + '?imageView2/0/w/90/h/90',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              // radio选择框
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
//          color: Colors.redAccent,
                      margin: EdgeInsets.only(top: 10),
//                      width: ScreenUtil().setWidth(480),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SelectRadio(
                            allApply: _allApply,
                            radioValue: _imgControList[index]['radioValue'],
                            checkBox: _imgControList[index]['checkTag'],
                            priceController: _imgControList[index]['price'],
                            minPriceController: _imgControList[index]
                                ['minprice'],
                            maxPriceController: _imgControList[index]
                                ['maxprice'],
                            selectAction: (e) {
//                              print(e);
                              setState(() {
                                _imgControList[index]['radioValue'] = e;
                              });
                            },
                            checkAction: (e) {
                              setState(() {
                                _imgControList[index]['checkTag'] = e;
                              });
                            },
                          ), // 不定价 一口价 区间价
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // 商品描述输入框
          _productDescWidget(index),
//          编辑标签
          _historyTagWidget(index),
          // 应用于所有
          index == 0
              ? InkWell(
                  onTap: () {
                    TextEditingController con = _imgControList[0]['descCon'];
                    TextEditingController priceCon = _imgControList[0]['price'];
                    TextEditingController minPricecon =
                        _imgControList[0]['minprice'];
                    TextEditingController maxPricecon =
                        _imgControList[0]['minprice'];
                    String radio = _imgControList[0]['radioValue'];
                    List tagList = _imgControList[0]['tagList'];

                    print(tagList);
//                    if (con.text == '') {
//                      return;
//                    }
                    Future.delayed(Duration(milliseconds: 200)).then((e) {
                      if (_allApply == false) {
                        List<Map> _list = _imgControList;
                        _list.forEach((e) {
                          e['descCon'].text = con.text;
                          e['price'].text = priceCon.text;
                          e['minprice'].text = minPricecon.text;
                          e['maxprice'].text = maxPricecon.text;
                          e['radioValue'] = radio;
                          e['checkTag'] = true;
                          e['tagList'] = tagList;
                        });

                        setState(() {
                          _allApply = true;
                          _imgControList = _list;
                        });
                        eventBus.fire(new RadioValue(radio));
                      } else {
                        setState(() {
                          _allApply = false;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      _allApply == true
                          ? Image.asset('assets/icon_detail_add_yellow.png')
                          : Image.asset('assets/icon_share_unchecked.png'),
                      Text('  应用于所有')
                    ],
                  ),
                )
              : Container(
                  height: 0,
                ),
        ],
      ),
    );
  }

  /*
  * 商品名
  * */
  Widget _productDescWidget(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 40,
        child: Theme(
          data: ThemeData(
            primaryColor: Color.fromRGBO(187, 187, 187, 1),
          ),
          child: TextField(
            cursorColor: Color.fromRGBO(187, 187, 187, 1),
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            textInputAction: TextInputAction.next,
            onSubmitted: (e) {},
            onChanged: (e) {
              eventBus.fire(new ProductName(e));
            },
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
            controller: _imgControList[index]['descCon'],
          ),
        ),
      ),
    );
  }

  /*
  * 历史标签
  * */
  Widget _videoHistoryTagWidget() {
    if (_videoTagList.length > 0) {
      return Container(
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _videoTagList.map((childNode) {
            return GestureDetector(
              onTap: () async {
                if (childNode == '+ 编辑标签') {
                  Set set = _videoTagList.toSet();
                  List<String> resultList = set.toList();

                  // 发过去,先去除 '' 和标签标签
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
  * 历史标签
  * */
  Widget _historyTagWidget(int index) {
    List<String> list = _imgControList[index]['tagList'];
//    print(list);
    if (list.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: list.map((childNode) {
            return GestureDetector(
              onTap: () async {
                if (childNode == '+ 编辑标签') {
                  Set set = list.toSet();
                  List<String> resultList = set.toList();

                  // 发过去,先去除 '' 和标签标签
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
                          num: index,
                          tag: 'image',
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
 * 主体布局
 * */
  Widget _buildEditableActivityItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: _imgControList.length + 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return widget.shoppingWallRag == true
                ? Text('')
                : _buildTopicMessageArea(); // 发布输入框
          } else if (index == _imgControList.length + 1) {
            return _videoControList.length == 0
                ? _buildPublishEntryPointArea()
                : Text(''); // 中部的选择图片按钮 + 文字
          } else if (index == _imgControList.length + 2) {
            return _imgControList.length == 0
                ? _buildPublishEntryPointVideoArea()
                : Text(''); // 中部的选择视频按钮 + 文字
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: _buildThumbnailAndPriceArea(index - 1),
            ); // 图片UI一栏
          }
        },
      ),
    );
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
      dividerColor: Colors.grey,
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected:
          widget.shoppingWallRag == true ? 9999 : 9 - _imgControList.length,
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

      setState(() {
        _uploadImgConunt = imgList.length;
      });
      for (var e in imgList) {
        setState(() {
          _showLoadingTag = true;
        });
        var file = await e.file;

//        String base64Image = base64Encode(file.readAsBytesSync());
//        String fileName = file.path.split("/").last;
//
//        FormData formData = FormData.fromMap({
//          "file": await MultipartFile.fromFile(file.absolute.path,
//              filename: '22.png'),
//        });
//
//        http
//            .post(
//          'https://content.xiaomaimaiquan.com/api/v2b/Content/UploadImageFiles',
//          headers: {
//            "wbhost": CustomerApi().getStoreHost(),
//            "StoreGuid": CustomerApi().getStoreGuid(),
//            "token": CustomerApi().getToken(),
//            "Platform": "app",
//            "FileDescription": jsonEncode(
//              {
//                "FileName": fileName,
//                "FileType": "image",
//              },
//            )
//          },
//          body: jsonEncode({
//            "image": base64Image,
//            "name": fileName,
//          }),
//        )
//            .then((res) {
//          print(res);
//          print(res.body);
//        }).catchError((e) {
//          print(e);
//        });

        // 压缩
        int nIndex = file.absolute.path.lastIndexOf("/");
        var imgName = file.absolute.path.substring(nIndex + 1);
        var imgName1 = file.absolute.path.substring(0, nIndex);
//        print(file.absolute.path);
//        print(imgName1);

        final imgFile =
            await testCompressAndGetFile(file, '${imgName1}/0${imgName}');

        _uploadImg(EditableActivityItem(thumbnail: imgFile.path));
      }
    }

    setState(() {});
  }

  /*
  * 压缩图片
  * */
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 20,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  /*
  * 选择图片按钮 + 底部文字
  * */
  Widget _buildPublishEntryPointArea() {
    return _imgControList.length == 9
        ? Text('')
        : Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTakePictureArea(), // 选择图片按钮
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: widget.shoppingWallRag == true
                      ? Text(
                          '*继续上传图片',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                          ),
                        )
                      : Text(
                          '*图片还能添加${9 - _imgControList.length}张',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                          ),
                        ),
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
      width: 100,
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        style: TextStyle(
          fontSize: 18,
          textBaseline: TextBaseline.alphabetic,
        ),
        keyboardType: TextInputType.number,
        controller: _videoPriceController,
        decoration: InputDecoration(
            icon: Text(
              '¥',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFB0B0B0),
              ),rr
            ),
            border: InputBorder.none,
            hintText: '输入价格'),
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
              style: TextStyle(
                fontSize: 18,
                textBaseline: TextBaseline.alphabetic,
              ),
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
              controller: _videoMinPriceController,
            ),
          ),
          Text('~'),
          Container(
            width: ScreenUtil().setWidth(200),
            child: TextField(
              cursorColor: Color.fromRGBO(187, 187, 187, 1),
              style: TextStyle(
                fontSize: 18,
                textBaseline: TextBaseline.alphabetic,
              ),
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
              controller: _videoMaxPriceController,
            ),
          ),
        ],
      ),
    );
  }
//
//  /*
// * 分享时隐藏按钮
// * */
//  Widget _buildShareArea() {
//    return Container(
//      width: 200,
//      height: 40,
//      child: Row(
//        children: <Widget>[
//          Checkbox(
//            activeColor: Colors.yellow,
//            value: true,
//            onChanged: (bool value) {
//              setState(() {});
//            },
//          ),
//          Text(
//            '分享时隐藏商品价格',
//            style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
//          )
//        ],
//      ),
//    );
//  }

  /*
  * 选择视频按钮 + 底部文字
  * */
  Widget _buildPublishEntryPointVideoArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _videoControList.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                        '${_videoControList[0]['videourl']}?vframe/jpg/offset/0|imageView2/1/w/400/h/200'),
                                  ),
                                ),
                              )
                            : Text(''),
                        _playingTag == false
                            ? Positioned(
                                top: 80,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 40,
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
                    _imgRadioValue == '一口价'
                        ? _buildPriceArea()
                        : _buildPriceSwitchArea(), // 价格区间按钮
                    // 分享时隐藏按钮
//                    _buildShareArea(),
                    _videoNameWidget(),
                    _videoHistoryTagWidget(),
                  ],
                )
              : _buildTakeVideoArea(), // 选择视频按钮
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              '*可以选择一个视频',
              style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * 商品名
  * */
  Widget _videoNameWidget() {
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
            controller: _videoNameController,
          ),
        ),
      ),
    );
  }

  /*
  * 输入条
  * */
  Widget _someRadioWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
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
  * 选择视频按钮
  * */
  Widget _buildTakeVideoArea() {
    return GestureDetector(
      onTap: _onTapAddVideo,
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
  * 选择一个视频
  * */
  void _onTapAddVideo() {
    _optionsVideoDialogBox().then((v) => {});
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
                    onTap: () async {
                      var assetPathList = await PhotoManager.getImageAsset();
                      _pickAsset(PickType.onlyImage, pathList: assetPathList);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /*
  * 选择视频对话框
  * */
  Future<void> _optionsVideoDialogBox() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('摄像头拍摄'),
                  onTap: takeVideo,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('从手机视频里选择'),
                  onTap: getVideo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

/*选取视频*/
  getVideo() async {
    Navigator.pop(context);
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    print('选取视频：' + video.toString());
    if (video != null) {
      setState(() {
        _showLoadingTag = true;
      });

//       拿到视频就上传
      _uploadVideo(EditableActivityItem(thumbnail: video.path));
    }
  }

/*拍摄视频*/
  takeVideo() async {
    Navigator.pop(context);
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);
    print('拍摄视频：' + video.toString());
    if (video != null) {
      setState(() {
        _showLoadingTag = true;
      });
      // 拿到视频就上传
      _uploadVideo(EditableActivityItem(thumbnail: video.path));
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
      setState(() {
        _showLoadingTag = true;
      });

      int nIndex = picture.absolute.path.lastIndexOf("/");
      var imgName = picture.absolute.path.substring(nIndex + 1);
      var imgName1 = picture.absolute.path.substring(0, nIndex);
//        print(file.absolute.path);
//        print(imgName1);
      // 压缩
      final imgFile =
          await testCompressAndGetFile(picture, '${imgName1}/0${imgName}');
      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: imgFile.path));
    }
  }

  /*
  * 打开相册
  * */
//  void openGallery() async {
//    Navigator.of(context).pop();
//    var gallery = await ImagePicker.pickImage(
//      source: ImageSource.gallery,
//    );
//
//    if (gallery != null) {
//      // 拿到图片就上传
//      _uploadImg(EditableActivityItem(thumbnail: gallery.path));
//    }
//  }

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
    _response = await dio
        .post(url,
            options: Options(headers: {
              "wbhost": CustomerApi().getStoreHost(),
              "StoreGuid": CustomerApi().getStoreGuid(),
              "token": CustomerApi().getToken(),
              "Platform": "app",
              "FileDescription": jsonEncode(
                {
                  "FileName": "$imgName",
                  "FileType": "image",
                },
              )
            }),
            data: formData)
        .catchError((e) {
      print('上传失败 $e');
      setState(() {
        _showLoadingTag = false;
      });
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "有图片上传失败了",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    });
//    print(_response);
    if (_response.data['Success'] == true) {
      var _img_url = _response.data['Data']['$imgName'];

      setState(() {
        _uploadImgSuccess++;
      });

      if (_uploadImgConunt == _uploadImgSuccess) {
        setState(() {
          _uploadImgSuccess = 0;
          _showLoadingTag = false;
        });
      }

      setState(() {
        _imgControList.add({
          'tag': false,
          'price': TextEditingController(),
          'minprice': TextEditingController(),
          'maxprice': TextEditingController(),
          'descCon': TextEditingController(),
          'imgurl': _img_url,
          'tagList': ['+ 编辑标签'],
          'checkTag': false,
          'radioValue': '一口价'
        });
      });

      setState(() {
        items.add(EditableActivityItem(thumbnail: e.thumbnail));
      });
    } else {
      setState(() {
        _showLoadingTag = false;
      });
    }
  }

  /*
  * 得到视频就上传 单个
  * */
  _uploadVideo(EditableActivityItem e) async {
    var filePath = e.thumbnail;
    final info = await _flutterVideoCompress.getMediaInfo(e.thumbnail);
    int duration = (info.duration / 1000).toInt();
    if (duration > 10) duration = 10;
    int totalSize = info.filesize;
    int quality = 100;
    if (totalSize > _maximumFileSize) {
      final info2 = await _flutterVideoCompress.compressVideo(e.thumbnail,
          quality: VideoQuality.MediumQuality,
          startTime: 0,
          duration: duration);
      filePath = info2.path;
    }
    int nIndex = filePath.lastIndexOf("/");
    var imgName = filePath.substring(nIndex + 1);

    ///nowDateMilliseconds.toString();
    Response _response;
    Dio dio = Dio();
    File img_file = File(filePath);
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
          "FileDescription": jsonEncode(
            {
              "FileName": "$imgName",
              "FileType": "video",
            },
          )
        }),
        data: formData);
    print('上传视频$_response');
    if (_response.data['Success'] == true) {
      var _video_url = _response.data['Data']['$imgName'];

      setState(() {
        _showLoadingTag = false;
      });

      setState(() {
        _videoControList.add({
          'tag': '0',
          'price': TextEditingController(),
          'minprice': TextEditingController(),
          'maxprice': TextEditingController(),
          'videourl': _video_url,
        });
      });
      await _videoController.setNetworkDataSource(_video_url, autoPlay: false);

      setState(() {
        items.add(EditableActivityItem(thumbnail: filePath));
      });
    } else {
      setState(() {
        _showLoadingTag = false;
      });
    }
  }

  /*
  * 发布按钮点击事件-视频
  * */
  void _handleTapPublishVideoSuccess() async {
    String _name = _videoNameController.text;
    if (_name.length == 0) {
      setState(() {
        _OKbtnEnable = true;
      });
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: '名称为必填项～',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }

    String guid = '';
    if (widget.list != null) {
      guid = widget.list[0].Guid;
    } else {
      guid = '';
    }

//    print(_videoControList[0]['videourl']);

    _videoTagList.remove('+ 编辑标签');
    var formData = {
      "RangePriceRequired": false,
      "confirmPriceRequired": true,
      "description": _videoNameController.text ?? '', // 商品名称放这里
      "displayOnHomePage": 1,
      "displayOrder": 0,
      "maxprice": _videoMaxPriceController.text == ""
          ? 0
          : double.parse(_videoMaxPriceController.text),
      "minprice": _videoMinPriceController.text == ""
          ? 0
          : double.parse(_videoMinPriceController.text),
      "pictureList": [],
      "VideoUrl": _videoControList[0]['videourl'],
      "TagList": _videoTagList,
      "price": _videoPriceController.text == ""
          ? 0
          : double.parse(_videoPriceController.text),
      "productName": '',
      "status": 1,
      "guid": "$guid"
    };

    var UpdateProductsOnlyTag = widget.shoppingWallRag == true ? true : false;

    Map map = {};

    String des = _editController.text;
    List<String> desList = des.split('#');
    print(desList);
    if (desList.length == 3) {
      map['groupName'] = desList[1];
      map['description'] = desList[2];
    } else if (desList.length == 1) {
      map['groupName'] = '';
      map['description'] = desList[0];
    } else if (desList.length == 2) {
      map['groupName'] = '';
      map['description'] = desList[1];
    } else {
      map['groupName'] = '';
      map['description'] = des;
    }
    map['displayOrder'] = 0;
    map['status'] = 1;
    map['productList'] = [formData];
    map['UpdateProductsOnly'] = UpdateProductsOnlyTag;

    var response = await CustomerApi().AddNewMoment(context, map);
//    print(response);
    if (response['Success'] == true) {
      setState(() {
        _OKbtnEnable = true;
      });
      items.clear();
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

//    Application.router.navigateTo(context, "./publish_activity_success",
//        transition: TransitionType.inFromRight);
  }

  /*
  * 发布按钮点击事件-图片
  * */
  void _handleTapPublishPictureSuccess() async {
    String guid = '';
    if (widget.list != null) {
      guid = widget.list[0].Guid;
    } else {
      guid = '';
    }

    for (var i = 0; i < _imgControList.length; i++) {
      String name = _imgControList[i]['descCon'].text;

      if (name.length == 0) {
        setState(() {
          _OKbtnEnable = true;
        });
//        print('必填项');
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: '名称为必填项～',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
        return;
      }
    }

    var paramList = [];
    _imgControList.forEach((e) {
      List list = e['tagList'];
      list.remove('+ 编辑标签');
      var formData = {
        "RangePriceRequired": false,
        "confirmPriceRequired": true,
        "description": e['descCon'].text ?? '', // 商品名称放这里
        "displayOnHomePage": 1,
        "displayOrder": 0,
        "maxprice":
            e['maxprice'].text == "" ? 0 : double.parse(e['maxprice'].text),
        "minprice":
            e['minprice'].text == "" ? 0 : double.parse(e['minprice'].text),
        "pictureList": [e['imgurl']],
        "TagList": list,
        "price": e['price'].text == "" ? 0 : double.parse(e['price'].text),
        "productName": '',
        "status": 1,
//          "guid": "$guid"
      };
      paramList.add(formData);
    });

    // 发布产品
    var UpdateProductsOnlyTag = widget.shoppingWallRag == true ? true : false;

    Map map = {};

    String des = _editController.text;
    List<String> desList = des.split('#');
    print(desList);
    if (desList.length == 3) {
      map['groupName'] = desList[1];
      map['description'] = desList[2];
    } else if (desList.length == 1) {
      map['groupName'] = '';
      map['description'] = desList[0];
    } else if (desList.length == 2) {
      map['groupName'] = '';
      map['description'] = desList[1];
    } else {
      map['groupName'] = '';
      map['description'] = des;
    }
    map['displayOrder'] = 0;
    map['status'] = 1;
    map['productList'] = paramList;
    map['UpdateProductsOnly'] = UpdateProductsOnlyTag;

    print('mapmap--- $map');

    var response = await CustomerApi().AddNewMoment(context, map);
    if (response['Success'] == true) {
      setState(() {
        _OKbtnEnable = true;
      });
      items.clear();
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

//    Application.router.navigateTo(context, "./publish_activity_success",
//        transition: TransitionType.inFromRight);
  }
}

// 不定价 & 一口价 & 区间价
class SelectRadio extends StatefulWidget {
  Function selectAction;
  Function checkAction;
  final TextEditingController priceController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final bool checkBox;
  final bool allApply;
  final String radioValue;

  SelectRadio({
    Key key,
    @required this.selectAction(String value),
    @required this.checkAction(bool tag),
    @required this.priceController,
    @required this.minPriceController,
    @required this.maxPriceController,
    @required this.checkBox,
    @required this.allApply,
    @required this.radioValue,
  }) : super(key: key);

  @override
  _SelectRadioState createState() => _SelectRadioState();
}

class _SelectRadioState extends State<SelectRadio>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String _radioValue = '一口价';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _radioValue = widget.radioValue;
    });
  }

  @override
  bool get wantKeepAlive => true;

  //监听Bus events
  void _listen() {
    eventBus.on<InputPrice>().listen((event) {
      if (widget.allApply == true) {
        widget.priceController.text = event.str;
      }
    });

    eventBus.on<MinInputPrice>().listen((event) {
      if (widget.allApply == true) {
        widget.minPriceController.text = event.str;
      }
    });

    eventBus.on<MaxInputPrice>().listen((event) {
      if (widget.allApply == true) {
        widget.maxPriceController.text = event.str;
      }
    });

    eventBus.on<RadioValue>().listen((event) {
      setState(() {
        _radioValue = event.str;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _radioValue = '一口价';
                  });
                  if (widget.allApply == true) {
                    eventBus.fire(new RadioValue('一口价'));
                  }

                  widget.selectAction('一口价');
                },
                child: Row(
                  children: <Widget>[
                    _radioValue == '一口价'
                        ? Image.asset('assets/icon_detail_add_yellow.png')
                        : Image.asset('assets/icon_share_unchecked.png'),
                    Text('一口价')
                  ],
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    _radioValue = '区间价';
                  });
                  if (widget.allApply == true) {
                    eventBus.fire(new RadioValue('区间价'));
                  }
                  widget.selectAction('区间价');
                },
                child: Row(
                  children: <Widget>[
                    _radioValue == '区间价'
                        ? Image.asset('assets/icon_detail_add_yellow.png')
                        : Image.asset('assets/icon_share_unchecked.png'),
                    Text('区间价')
                  ],
                ),
              ),
            ],
          ),
          _radioValue == '一口价'
              ? _buildPriceArea()
              : _buildPriceSwitchArea(), // 价格区间按钮
          // 分享时隐藏按钮
//        _buildShareArea(),
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
      width: 100,
      child: TextField(
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        style: TextStyle(fontSize: 18, textBaseline: TextBaseline.alphabetic),
        keyboardType: TextInputType.number,
        controller: widget.priceController,
        onChanged: (e) {
          eventBus.fire(new InputPrice(e));
        },
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
//          Switch(
//            value: _imgControList[index]['tag'],
//            onChanged: (bool value) {
//              _changeControAction(index, value);
//            },
//          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5),
                width: ScreenUtil().setWidth(180),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  style: TextStyle(
                    fontSize: 18,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  onChanged: (e) {
                    eventBus.fire(new MinInputPrice(e));
                  },
                  decoration: InputDecoration(
                    icon: Text(
                      '¥',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: widget.minPriceController,
                ),
              ),
              Text('~'),
              Container(
                margin: EdgeInsets.only(left: 5),
                width: ScreenUtil().setWidth(180),
                child: TextField(
                  cursorColor: Color.fromRGBO(187, 187, 187, 1),
                  style: TextStyle(
                    fontSize: 18,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  onChanged: (e) {
                    eventBus.fire(new MaxInputPrice(e));
                  },
                  decoration: InputDecoration(
                    icon: Text(
                      '¥',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: widget.maxPriceController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /*
 * 分享时隐藏按钮
 * */
//  Widget _buildShareArea() {
//    return Container(
//      width: 200,
//      height: 40,
//      child: Row(
//        children: <Widget>[
//          Checkbox(
//            activeColor: Colors.yellow,
//            value: widget.checkBox,
//            onChanged: (bool value) {
//              widget.checkAction(value);
//            },
//          ),
//          Text(
//            '分享时隐藏商品价格',
//            style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
//          )
//        ],
//      ),
//    );
//  }
}
