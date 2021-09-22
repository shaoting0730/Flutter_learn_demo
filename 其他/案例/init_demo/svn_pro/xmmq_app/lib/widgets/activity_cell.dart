/*
* 店主动态-主体
* */
import 'dart:convert';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:popup_menu/popup_menu.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

import '../utils/utils.dart';
import './product_thumbnail.dart';
import '../utils/customDialog/share_dialog.dart';
import '../routers/application.dart';
import '../models/api/goodsGroup.dart';
import '../utils/utils.dart';
import '../serviceapi/customerapi.dart';
import '../pages/store_main.dart';
import '../bloc/isPicWall_bloc.dart';
import '../serviceapi/baseapi.dart';
import '../models/api/shareImage.dart';
import '../pages/store_dynamic/activity_context.dart';
import '../models/api/customer.dart';
import '../utils/event_bus.dart';
import '../widgets/video_widget.dart';

class ActivityCell extends StatefulWidget {
  final ListObjectsModel model;
  final StoreInfoModel storeInfoModel;
  final List<ListObjectsModel> list;
  final int index;
  Function deleteCallback;
  Function shareCallback;
  Function startCallback;
  Function topCallback;

  ActivityCell({
    Key key,
    @required this.model,
    @required this.storeInfoModel,
    @required this.index,
    @required this.list,
    @required this.deleteCallback,
    @required this.shareCallback,
    @required this.startCallback,
    @required this.topCallback,
  }) : super(key: key);
  @override
  State<ActivityCell> createState() {
    return ActivityCellState();
  }
}

class ActivityCellState extends State<ActivityCell>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool _isMe = true; // 默认本人登录
  ShareImageModel _shareModel; // 分享的model
  bool _isWeChatInstalledTag = false; // 是否安装了微信
  bool _btnEnable = true; // 点赞按钮可用性
  String _share_url = ''; // 分享的图片链接
  StreamSubscription<fluwx.WeChatAuthResponse> _wxListener = null;
  double _top = 0.0;
  GlobalKey _btnKey = GlobalKey();
  ListObjectsModel _model;
  int _DisableComment = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    print(jsonEncode(widget.model));
    setState(() {
      _model = widget.model;
      _DisableComment = CustomerApi().getDisableComment();
    });

    _getLocalTag();
    if (_wxListener != null) {
      _wxListener.cancel();
      _wxListener = null;
    }
    _registerAction();
  }

  _registerAction() async {
    fluwx.responseFromShare.listen((data) {
      print('分享回调');
      print(data.errCode);
      widget.shareCallback();
    });
  }

  void _openMenu() {
    PopupMenu menu = PopupMenu(
      maxColumn: 1,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
      items: [
        MenuItem(title: '设为置顶'),
        MenuItem(title: '删除'),
      ],
      onClickMenu: (e) {
        print(e.menuTitle);
      },
    );
    menu.show(widgetKey: _btnKey);
  }

  /*
  * 获取是否本人标示
  * */
  _getLocalTag() async {
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tag = prefs.getBool(IS_ME_KEY);
    if (tag == null) {
      tag = true;
    }

    setState(() {
      _isMe = tag;
    });
  }

  //监听Bus events
  void _listen() {
    eventBus.on<DisableComment>().listen((event) {
      if (mounted) {
        _DisableComment = event.tag;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    _listen();
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTimeline(),
          SizedBox(width: 10),
          _buildContentArea(context)
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    var text = DateFormat('MM-dd')
        .format(Utils.fromAspDateTimeTicks(widget.model.UpdatedOn));
    return Container(
//      color: Colors.red,
        width: 60,
        padding: EdgeInsets.only(left: 15, top: _top),
        child: Column(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
              ),
            ),
            _model.AtTheTop == 1
                ? Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 1,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(254, 122, 122, 1),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '置顶',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color.fromRGBO(254, 122, 122, 1),
                      ),
                    ),
                  )
                : Text(''),
          ],
        ));
  }

  Widget _buildContentArea(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildContentTextArea(),
          _buildContentImageArea(),
//        SizedBox(height: 10),
//        _buildSocialArea(context),
          SizedBox(height: 10),
          _buildWechatSharingArea(context),
          _DisableComment == 0 ? _commentWidget() : Text(''),
        ],
      ),
    );
  }

  Widget _commentWidget() {
    if (_model.Comments.length == 0) {
      return Container();
    }
    List<CommentsModel> list = [];
    if (_model.Comments.length <= 3) {
      list = _model.Comments;
    } else {
      list = _model.Comments.sublist(0, 3);
    }
//    print(list.length);
    List<Widget> _listWidget = [];
    list.map((e) {
      _listWidget.add(
        Container(
//          color: Colors.red,
          child: Row(
            children: <Widget>[
              Text(
                '${e.StoreCustomerName}:',
                style: TextStyle(
                  color: Color.fromRGBO(253, 159, 60, 1),
                ),
              ),
              Expanded(
                child: Text(
                  ' ${e.Content}',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityContext(
              list: widget.list,
              model: widget.model,
              storeInfoModel: widget.storeInfoModel,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 15),
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          children: _listWidget,
        ),
      ),
    );
  }

  Widget _buildContentTextArea() {
    var txt = _model.Description;
    var topicName = _model.GroupName;
//    print('Description ${widget.model.Description}');
//    print('GroupName ${widget.model.GroupName}');
    List list = txt.split('#');

//    print('-----');
//    print('----- $list');
//    print('-----');
    var desc = '';
    if (list.length == 2) {
      for (var i = 0; i < list.length; i++) {
        if (i > 1) {
          desc += list[i];
        }
      }
    } else if (list.length > 2) {
      desc = txt;
    }

    if (txt.length == 0 && topicName.length == 0) {
      return Container(
        height: 0,
      );
    } else {
      setState(() {
        _top = 2.0;
      });
      return InkWell(
        onLongPress: () {
          if (list.length > 1) {
            if (desc.length > 0) {
              Clipboard.setData(ClipboardData(text: desc));
              Fluttertoast.showToast(
                  backgroundColor: Color(0xFF666666),
                  msg: "商品名已经复制",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER);
            }
          } else {
            if (widget.model.Description.length > 0) {
              Clipboard.setData(ClipboardData(text: widget.model.Description));
              Fluttertoast.showToast(
                  backgroundColor: Color(0xFF666666),
                  msg: "商品名已经复制",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER);
            }
          }
        },
        child: Container(
//        margin: EdgeInsets.only(top: 0),
          child: RichText(
            text: TextSpan(
              text: list.length > 1
                  ? list[2] == '' ? '' : '#${list[1]}#'
                  : topicName == '' ? '' : '#$topicName#',
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(255, 173, 78, 1),
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: list.length > 1 ? '$desc' : widget.model.Description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildContentImageArea() {
    List<Widget> listWidget = [];

    double width = 0.0;
    double media_w = MediaQuery.of(context).size.width - 55.0 - 10.0;
    List list = widget.model.PictureList;
    if (list.length <= 4) {
      width = (media_w / 2 - 5) - 8;
    } else {
      width = (media_w / 3 - 5) - 5;
    }

    for (var i = 0; i < widget.model.PictureList.length; i++) {
      if (widget.model.PictureList[i].IsVideo == true) {
        // 视频
        return VideoWidget(videoStr: widget.model.PictureList[0].ImageUrl);
      } else {
        if (widget.model.ProductList.length == 0) {
          // 全部已下架
          listWidget.add(
            Stack(
              children: <Widget>[
                Image.network(
                  '${widget.model.PictureList[i].ImageUrl}?imageView2/0/w/230/h/230',
                  width: width,
                  height: width,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '全部下架',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (widget.model.ProductList.length ==
            widget.model.PictureList.length) {
          listWidget.add(
            Stack(
              children: <Widget>[
                Image.network(
                  '${widget.model.PictureList[i].ImageUrl}?imageView2/0/w/230/h/230',
                  width: width,
                  height: width,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '全部在架',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          //
          //  判断规则....
          //
          // 下架+在架
          listWidget.add(
            Stack(
              children: <Widget>[
                Image.network(
                  '${widget.model.PictureList[i].ImageUrl}?imageView2/0/w/230/h/230',
                  width: width,
                  height: width,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    }

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: listWidget,
    );
  }

  /*
  * 价格遮罩UI
  * */
  Widget _imgsWidget1(int index,
      {ProductListModel proModel, List<PictureListModel> picModelList}) {
    double width = 0.0;
    double media_w = MediaQuery.of(context).size.width - 55.0 - 10.0;
    List list = widget.model.ProductList;
    if (list.length <= 4) {
      width = (media_w / 2 - 5) - 8;
    } else {
      width = (media_w / 3 - 5) - 5;
    }
    picModelList.forEach((e) {
      proModel.PictureList.contains(e.ImageUrl);
    });

    return ProductThumbnail(
      storeInfomodel: widget.storeInfoModel,
      width: width,
      list: widget.list,
      index: index,
      picStr: proModel.PictureList.length > 0 ? proModel.PictureList[0] : '',
      videoStr: proModel.VideoUrl,
      price: _deducePrice(proModel.Price, proModel.MinPrice, proModel.MaxPrice),
      model: widget.model,
    );
  }

  /*
  * 价格遮罩UI
  * */
  Widget _imgsWidget(ProductListModel model, int index) {
    double width = 0.0;
    double media_w = MediaQuery.of(context).size.width - 55.0 - 10.0;
    List list = widget.model.ProductList;
    if (list.length <= 4) {
      width = (media_w / 2 - 5) - 8;
    } else {
      width = (media_w / 3 - 5) - 5;
    }

    return ProductThumbnail(
      storeInfomodel: widget.storeInfoModel,
      width: width,
      list: widget.list,
      index: index,
      picStr: model.PictureList.length > 0 ? model.PictureList[0] : '',
      videoStr: model.VideoUrl,
      price: _deducePrice(model.Price, model.MinPrice, model.MaxPrice),
      model: widget.model,
    );
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

  /*
  * 分享 投放广告
  * */
  Widget _buildSocialArea(context) {
    ListObjectsModel model = widget.model;
    return Row(
      children: <Widget>[
        _isWeChatInstalledTag == true
            ? InkWell(
                onTap: () async {
//            var text =
//                '${model.ProductList[0].ProductName}  ${model.Description}';
//            Application.router.navigateTo(
//                context, "./edit_share?text=${Uri.encodeComponent(text)}",
//                transition: TransitionType.inFromRight);

//                  widget.shareCallback(); // 回调父组件先行,加载中

                  ListObjectsModel model = widget.model;
                  String Guid = model.Guid;
                  await CustomerApi()
                      .GetDQMomentSharePicture(context, Guid)
                      .then((val) {
                    setState(() {
                      _shareModel = val;
                    });
                    var url = val.data.imageUrl;
                    print('分享');
                    print(url);
                    fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;
                    String _webPageUrl = "http://www.qq.com";
                    String _thumbnail = url;
//                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534614311230&di=b17a892b366b5d002f52abcce7c4eea0&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170516%2F51296b2673704ae2992d0a28c244274c_th.png";
                    String _title = model.Description;
                    String _userName = "gh_fa3f54a90163";
                    String _path = "/pages/media";
                    String _description = "";
                    var sharemodel = new fluwx.WeChatShareMiniProgramModel(
                        webPageUrl: _webPageUrl,
                        userName: _userName,
                        title: _title,
                        path: _path,
                        description: _description,
                        scene: fluwx.WeChatScene.SESSION,
                        hdImagePath: _thumbnail,
                        thumbnail: _thumbnail);
                    fluwx.share(sharemodel);
                  }).catchError((error) {
                    print(error);
                  });
                },
                child: _buildSocialActionButton(
                    Image.asset('assets/icon_home_share2.png'), "(分享)"),
              )
            : Text(''),
        _isMe == true
            ? Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
//                    _buildSocialActionButton(
//                        Image.asset('assets/icon_home_share.png'), "(投放广告)"),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => this._deleteAction(model),
                      child: _buildSocialActionButton(
                          Image.asset('assets/icon_home_share.png'), "删除"),
                    ),
                  ],
                ),
              )
            : Text('')
      ],
    );
  }

  Widget _buildSocialActionButton(var image, var title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image,
        SizedBox(width: 5),
        Text(title, style: TextStyle(color: Color(0xFF999999), fontSize: 13))
      ],
    );
  }

  /*
  * 左侧的点赞 和 评论按钮
  * */
  Widget _leftBtns() {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (_btnEnable == true) {
              if (mounted) {
                setState(() {
                  _btnEnable = false;
                });
              }
              if (_model.HasLiked == 1) {
//                print(jsonEncode(_model));
                //  取消点赞
                CustomerApi().RemoveLike(
                    context, {'GroupGuid': _model.Guid}).then((val) {
                  if (val['Success'] == true) {
                    if (mounted) {
                      setState(() {
                        _model.HasLiked = 0;
                        _model.Likes--;
                      });
                    }
                  }
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
                }).catchError((err) {
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
                  print(err);
                });
              } else {
                // 点赞
                CustomerApi().AddNewLike(
                    context, {'GroupGuid': _model.Guid}).then((val) {
                  if (val['Success'] == true) {
                    if (mounted) {
                      setState(() {
                        _model.HasLiked = 1;
                        _model.Likes++;
                      });
                    }
                  }
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
                }).catchError((err) {
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
                  print(err);
                });
              }
            }
          },
          child: Row(
            children: <Widget>[
              _model.HasLiked == 1
                  ? Image.asset('assets/icon_like_red.png')
                  : Image.asset('assets/icon_like_grey.png'),
              Text(
                '(${widget.model.Likes})  ',
                style: TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                ),
              )
            ],
          ),
        ),
        _DisableComment == 0
            ? InkWell(
                onTap: () {
                  print(widget.model);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityContext(
                        list: widget.list,
                        model: widget.model,
                        storeInfoModel: widget.storeInfoModel,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_comments_grey.png'),
                    Text(
                      '(${_model.Comments.length})',
                      style: TextStyle(
                        color: Color.fromRGBO(142, 142, 142, 1),
                      ),
                    ),
                  ],
                ),
              )
            : Text(''),
      ],
    );
  }

  /*
  * 右侧的分享 和 更多 按钮
  * */
  Widget _rightBtns() {
    return Row(
      children: <Widget>[
        _isWeChatInstalledTag == true
            ?
            // 一键分享
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return ShareDialog(
                        okCallback: () async {
                          // 分享朋友圈
                          widget.startCallback();
                          ListObjectsModel model = widget.model;
                          String Guid = model.Guid;
                          await CustomerApi()
                              .GetDQMomentSharePicture(context, Guid)
                              .then((val) {
                            if (val == null) {
                              widget.shareCallback();
                              return;
                            } else {
                              setState(() {
                                _shareModel = val;
                              });
                              print(val.data.imageUrl);
                              _shareWeixinTimeline(val.data.imageUrl);
                            }
                          }).catchError((error) {
                            widget.startCallback();
                            print(error);
                          });
                        },
                        otherCallback: () async {
                          // 分享给好友
                          widget.startCallback();
                          ListObjectsModel model = widget.model;
                          String Guid = model.Guid;
                          await CustomerApi()
                              .GetDQMomentSharePicture(context, Guid)
                              .then((val) {
                            if (val == null) {
                              widget.shareCallback();
                              return;
                            } else {
                              setState(() {
                                _shareModel = val;
                              });
                              print(val.data.imageUrl);
                              _shareWeixinSession(val.data.imageUrl);
                            }
                          }).catchError((error) {
                            widget.startCallback();
                            print(error);
                          });
                        },
                        dismissCallback: () {
                          print("取消了");
                        },
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
//              color: Color(0xFFFFAF4C),
//              border: Border.all(color: Color(0xFFFFAF4C), width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/icon_home_share.png',
                        width: 15,
                        height: 15,
                      ),
                      Text(
                        ' 分享  ',
                        style: TextStyle(
                          color: Color.fromRGBO(142, 142, 142, 1),
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Text(''),
        PopupMenuButton<String>(
          color: Color.fromRGBO(0, 0, 0, 0.8),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/icon_home_more.png',
                  width: 15,
                  height: 15,
                ),
                Text(
                  '更多',
                  style: TextStyle(
                    color: Color.fromRGBO(142, 142, 142, 1),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          onSelected: (String value) {
//            print(value);
            if (value == '设为置顶') {
              CustomerApi().SetMomentAtTop(context, {
                'AtTheTop': '1',
                'Guid': _model.Guid,
              }).then((e) {
                print(e);

                if (e['Success'] == true) {
                  widget.topCallback();
                }
              }).catchError((err) {
                print(err);
              });
            }

            if (value == '取消置顶') {
              CustomerApi().SetMomentAtTop(context, {
                'AtTheTop': '0',
                'Guid': _model.Guid,
              }).then((e) {
                print(e);
                if (e['Success'] == true) {
                  widget.topCallback();
                }
              }).catchError((err) {
                print(err);
              });
            }

            if (value == '删除') {
              _deleteAction(widget.model);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              child: _model.AtTheTop == 0
                  ? Text(
                      '设为置顶',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      '取消置顶',
                      style: TextStyle(color: Colors.white),
                    ),
              value: _model.AtTheTop == 0 ? '设为置顶' : '取消置顶',
            ),
            PopupMenuItem(
              child: Text(
                '删除',
                style: TextStyle(color: Colors.white),
              ),
              value: '删除',
            )
          ],
        ),

        /*
        * MaterialButton(
          height: 45.0,
          key: _btnKey,
          onPressed: _openMenu,
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/icon_home_more.png',
                width: 15,
                height: 15,
              ),
              Text(
                ' 更多',
                style: TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
        * */
      ],
    );
  }

  /*
  * 一键分享至朋友圈
  * */
  Widget _buildWechatSharingArea(context) {
    Clipboard.setData(ClipboardData(text: widget.model.Description));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _leftBtns(),
        _rightBtns(),
      ],
    );
  }
  /*
  * 一键分享至朋友圈
  * */
//  Widget _buildWechatSharingArea(context) {
//    Clipboard.setData(ClipboardData(text: widget.model.Description));
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: <Widget>[
//        _isWeChatInstalledTag == true
//            ?
//            // 一键分享
//            InkWell(
//                onTap: () {
//                  showDialog(
//                    context: context,
//                    barrierDismissible: true,
//                    builder: (BuildContext context) {
//                      return ShareDialog(
//                        okCallback: () async {
//                          // 分享朋友圈
//                          widget.startCallback();
//                          ListObjectsModel model = widget.model;
//                          String Guid = model.Guid;
//                          await CustomerApi()
//                              .GetDQMomentSharePicture(context, Guid)
//                              .then((val) {
//                            if (val == null) {
//                              widget.shareCallback();
//                              return;
//                            } else {
//                              setState(() {
//                                _shareModel = val;
//                              });
//                              print(val.data.imageUrl);
//                              _shareWeixinTimeline(val.data.imageUrl);
//                            }
//                          }).catchError((error) {
//                            widget.startCallback();
//                            print(error);
//                          });
//                        },
//                        otherCallback: () async {
//                          // 分享给好友
//                          widget.startCallback();
//                          ListObjectsModel model = widget.model;
//                          String Guid = model.Guid;
//                          await CustomerApi()
//                              .GetDQMomentSharePicture(context, Guid)
//                              .then((val) {
//                            if (val == null) {
//                              widget.shareCallback();
//                              return;
//                            } else {
//                              setState(() {
//                                _shareModel = val;
//                              });
//                              print(val.data.imageUrl);
//                              _shareWeixinSession(val.data.imageUrl);
//                            }
//                          }).catchError((error) {
//                            widget.startCallback();
//                            print(error);
//                          });
//                        },
//                        dismissCallback: () {
//                          print("取消了");
//                        },
//                      );
//                    },
//                  );
//                },
//                child: Container(
//                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                  decoration: BoxDecoration(
//                    color: Color(0xFFFFAF4C),
//                    border: Border.all(color: Color(0xFFFFAF4C), width: 1),
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(4),
//                    ),
//                  ),
//                  child: Row(
//                    children: <Widget>[
//                      Image.asset(
//                        'assets/icon_home_share2.png',
//                        width: 15,
//                        height: 15,
//                      ),
//                      Text(
//                        '  一键分享',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 15,
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              )
//            : Text(''),
//        // 删除
//        InkWell(
//          onTap: () => this._deleteAction(widget.model),
//          child: Container(
//            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//            margin: EdgeInsets.only(right: 20, left: 10),
//            decoration: BoxDecoration(
//              border: Border.all(color: Color(0xFF999999), width: 1),
//              borderRadius: BorderRadius.all(
//                Radius.circular(4.0),
//              ),
//            ),
//            child: Center(
//              child: Text(
//                '删除',
//                style: TextStyle(
//                  color: Color(0xFF999999),
//                  fontSize: 15,
//                ),
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//  }

  /*
  * 微信分享到朋友圈
  * */
  _shareWeixinTimeline(String url) async {
    fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;
    var des = widget.model.Description;

    print(url);
    var model = new fluwx.WeChatShareImageModel(
      image: url,
      thumbnail: url,
      transaction: url,
      scene: scene,
      description: '',
    );
    fluwx.shareToWeChat(model);
  }

  /*
  * 分享给朋友
  * */
  _shareWeixinSession(String url) async {
    fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;
    var des = widget.model.Description;

    print(url);
    var model = new fluwx.WeChatShareImageModel(
      image: url,
      thumbnail: url,
      transaction: url,
      scene: scene,
      description: '',
    );
    fluwx.shareToWeChat(model);
  }

  /*
  * 删除动态方法-提示框
  * */
  _deleteAction(ListObjectsModel model) {
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
          onPressed: () => this._delete(model),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  /*
  * 删除动态方法
  * */
  _delete(ListObjectsModel model) async {
    bool tag = await CustomerApi().RemoveMoment(context, model.Guid);
    if (tag == true) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "删除成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      Navigator.pop(context);
      widget.deleteCallback(); // 回到父组件,刷新数据
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (context) => StoreMainPage()),
//          (route) => route == null);
    } else {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "删除失败,请稍后再试",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }
}
