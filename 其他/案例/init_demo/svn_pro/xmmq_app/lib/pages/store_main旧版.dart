import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:xmmq_app/serviceapi/baseapi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo/photo.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';

import '../models/api/goods.dart';
import '../routers/application.dart';
import 'goods_manage/pictures_wall.dart';
import 'store_dynamic/seller_activities.dart';
import '../serviceapi/customerapi.dart';
import '../widgets/bottom_bar.dart';
import 'personal_center/me.dart';
import '../bloc/isPicWall_bloc.dart';
import 'store_dynamic/home_page.dart';
import '../models/editable_activity_item.dart';
import 'store_dynamic/publish_activity.dart';
import '../utils/event_bus.dart';

class StoreMainPage extends StatefulWidget {
  @override
  StoreMainPageState createState() {
    return StoreMainPageState();
  }
}

class StoreMainPageState extends State<StoreMainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final JPush jpush = JPush();
  var items = List<EditableActivityItem>();
  final _flutterVideoCompress = FlutterVideoCompress();
  final int _maximumFileSize = 2 * 1024 * 1024;
  double _tab_H = 61.0; // tag 高度

  List _list_img = []; // 上传图片数组
  int _post_num = 0; // 上传次数
  int pic_max = 0; // 所选择的图片个数

  TabController controller;
  int _tabIndex = 0;
  int _tabType = 0;

  var _tabImages;
  var _appBarTitles = ['首页', '我的'];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void _initData() {
    /*
     * 初始化选中和未选中的icon
     */
    _tabImages = [
      [
        _getTabImage('assets/icon_home_main_gray.png'),
        _getTabImage('assets/icon_home_main_yellow.png')
      ],
      [
        _getTabImage('assets/icon_my_main_gray.png'),
        _getTabImage('assets/icon_my_main_yellow.png')
      ]
    ];
  }

  /*
   * 根据image路径获取图片
   */
  Image _getTabImage(path) {
    return new Image.asset(path, width: 36.0, height: 36.0);
  }

  @override
  void initState() {
    initPushNotification();
    super.initState();

    _setupWechat();
  }

  Future _setupWechat() async {
    await fluwx.registerWxApi(
        appId: "wx8a57d592b64e5de4",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://www.xiaomaimaiquan.com/");
    var result = await fluwx.isWeChatInstalled();

    print('isWeChatInstalled: $result');
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPushNotification() async {
    jpush.setup(
      appKey: "ceceb8b4901258c487d48224",
      channel: "XMMQ",
      production: true,
      debug: false,
    );

    jpush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true));

    jpush.getRegistrationID().then((rid) {
      print("JPush RegistrationID: $rid");
      if (CustomerApi().getToken() != "" && rid != "") {
        CustomerApi().UpdateRegistrationId(context, rid);
      }
    });

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");

          if (message["extras"] != null) {
            Map notification;
            if (message["extras"]["cn.jpush.android.EXTRA"] != null) {
              notification =
                  jsonDecode(message["extras"]["cn.jpush.android.EXTRA"]);
            } else if (message["extras"] is Map) {
              notification = message["extras"];
            }
          }
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(
        _appBarTitles[curIndex],
        style: new TextStyle(
          fontSize: 14.0,
          color: const Color(0xff1296db),
        ),
      );
    } else {
      return new Text(
        _appBarTitles[curIndex],
        style: new TextStyle(
          fontSize: 16.0,
          color: const Color(0xff515151),
        ),
      );
    }
  }

  //监听Bus events
  void _listen() {
    eventBus.on<IsPicWall>().listen((event) {
      if (mounted) {
        if (event.tag == true) {
          setState(() {
            _tab_H = 61.0;
          });
        } else {
          setState(() {
            _tab_H = 0.0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _listen();

    return Scaffold(
        body: IndexedStack(
          index: _tabIndex,
          children: [
            HomePage(changeTab: (e) {
              setState(() {
                _tabType = e;
              });
            }),
            MePage(),
          ],
        ),
        bottomNavigationBar: BottomBar(
          height: _tab_H,
          color: Color(0xFF999999),
          centerItemText: _tabType == 0 ? '发布动态' : '批量上传',
          selectedColor: Color.fromRGBO(255, 175, 76, 1),
//          notchedShape: CircularNotchedRectangle(),
          items: [
            BottomBarItem(
              imageIcon: Image.asset(
                'assets/icon_home_main_gray.png',
                width: 35,
                height: 35,
              ),
              imageSelectedIcon: Image.asset(
                'assets/icon_home_main_yellow.png',
                width: 35,
                height: 35,
              ),
              text: '首页',
            ),
            BottomBarItem(
              imageIcon: Image.asset(
                'assets/icon_my_main_gray.png',
                width: 35,
                height: 35,
              ),
              imageSelectedIcon: Image.asset(
                'assets/icon_my_main_yellow.png',
                width: 35,
                height: 35,
              ),
              text: '我的',
            )
          ],
          onTabSelected: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _tab_H == 61.0
            ? _tabType == 0
                ? _buildFab_active(context)
                : _buildFab_shopping(context)
            : null);
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
      setState(() {
        _post_num++;
      });
    });
    if (_response.data['Success'] == true) {
      setState(() {
        _post_num++;
      });
      var _img_url = _response.data['Data']['$imgName'];
      _list_img.add(_img_url);

//      print('---${_list_img.length}');
      Map<String, dynamic> map = {};
      map['MinPrice'] = 0.0;
      map['MaxPrice'] = 0.0;
      map['Price'] = 0.0;
      map['PictureList'] = _list_img;

      ListObjectsGoodsModel model = ListObjectsGoodsModel.fromJson(map);
//      print(jsonEncode(model));
      List<ListObjectsGoodsModel> list = [];
      list.add(model);
      if (pic_max == _post_num) {
        eventBus.fire(new StartLoading(false));
        setState(() {
          pic_max = 0;
          _post_num = 0;
          _list_img = [];
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PublishActivity(
              list: list,
              shoppingWallRag: true,
            ),
          ),
        );
      }
    } else {
      eventBus.fire(new StartLoading(false));
    }
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
      eventBus.fire(new StartLoading(true));
      setState(() {
        pic_max = 1;
      });
//      // 拿到图片就上传
      _uploadImg(EditableActivityItem(thumbnail: picture.path));
    }
  }

  /*
  * 拍摄视频
  * */
  _videoAction() async {
    Navigator.pop(context);
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);
    print('拍摄视频：' + video.toString());
    if (video != null) {
      eventBus.fire(new StartLoading(true));

//      // 拿到视频就上传
      _uploadVideo(EditableActivityItem(thumbnail: video.path));
    }
  }

  /*
  * 打开视频集
  * */
  _openVideosAction() async {
    Navigator.pop(context);
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    print('选取视频：' + video.toString());
    if (video != null) {
      eventBus.fire(new StartLoading(true));

//      // 拿到视频就上传
      _uploadVideo(EditableActivityItem(thumbnail: video.path));
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
//    print('上传视频$_response');
    if (_response.data['Success'] == true) {
      var _video_url = _response.data['Data']['$imgName'];
      Map<String, dynamic> map = {};
      map['MinPrice'] = 0.0;
      map['MaxPrice'] = 0.0;
      map['Price'] = 0.0;
      map['PictureList'] = [];
      map['VideoUrl'] = _video_url;
      ListObjectsGoodsModel model = ListObjectsGoodsModel.fromJson(map);
//      print(jsonEncode(model));
      List<ListObjectsGoodsModel> list = [];
      list.add(model);
      eventBus.fire(new StartLoading(false));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublishActivity(
            list: list,
            shoppingWallRag: true,
          ),
        ),
      );
    } else {
      eventBus.fire(new StartLoading(false));
    }
  }

  /*
  * 打开相册
  * */

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
      maxSelected: 9999,
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
//      currentSelected = "not select item";
    } else {
      List<String> r = []; // img 真实路径数组

      for (var e in imgList) {
        eventBus.fire(new StartLoading(true));

        setState(() {
          pic_max = imgList.length;
        });
        var file = await e.file;
        _uploadImg(EditableActivityItem(thumbnail: file.absolute.path));
      }
    }

    setState(() {});
  }

  /*
  * 购物墙中间按钮
  * */
  Widget _buildFab_shopping(BuildContext context) {
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.only(top: 40),
      height: 72,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 265,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black54,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: _openCamera,
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  '拍照',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: () async {
                              var assetPathList =
                                  await PhotoManager.getImageAsset();
                              _pickAsset(PickType.onlyImage,
                                  pathList: assetPathList);
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  '从手机相册选择',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: _videoAction,
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  '拍视频',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          InkWell(
                            onTap: _openVideosAction,
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  '从手机视频选择',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            color: Color.fromRGBO(239, 239, 239, 1),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ).then((val) {
            print(val);
          });
        },
        child: Container(
          height: 90,
//          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Image.asset('assets/icon_publish_photo_yellow.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * 店主动态中间按钮
  * */
  Widget _buildFab_active(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, "./publish_activity",
              transition: TransitionType.inFromBottom);
        },
        child: Container(
//          color: Colors.red,
          margin: EdgeInsets.only(top: 40),
          height: 72,
//        width: 57,
//          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Image.asset('assets/icon_publish_add_yellow.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
