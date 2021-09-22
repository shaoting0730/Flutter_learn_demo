/*
* 店主动态详情
* */
import 'dart:convert';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter/services.dart';
import 'package:xmmq_app/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:common_utils/common_utils.dart';

import '../../models/api/goodsGroup.dart';
import '../../utils/utils.dart';
import '../../widgets/product_thumbnail.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/customer.dart';
import '../../utils/customDialog/share_dialog.dart';
import '../../utils/event_bus.dart';

class ActivityContext extends StatefulWidget {
  final ListObjectsModel model;
  final List list;
  final StoreInfoModel storeInfoModel;

  ActivityContext({Key key, this.model, this.list, this.storeInfoModel})
      : super(key: key);

  @override
  _ActivityContextState createState() => _ActivityContextState();
}

class _ActivityContextState extends State<ActivityContext> {
  double _top = 0.0;
  bool _isWeChatInstalledTag = false; // 是否安装了微信
  ListObjectsModel _model;
  bool _isShareing = false; // 是否点击了分享按钮
  bool _btnEnable = true; // 点赞按钮可用性
  var _inputControl = TextEditingController();
  var _listControl = ScrollController();
  FocusNode _contentFocusNode = FocusNode();
  String _ReplyToGuid = ''; // 当前点击的评论的_ReplyToGuid

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
  *  是否安装了微信
  * */
  _getWeChatInstalledTag() async {
    bool result = await fluwx.isWeChatInstalled();
    setState(() {
      _isWeChatInstalledTag = result;
    });
  }

  /*
  * 一键分享至朋友圈
  * */
  Widget _buildWechatSharingArea(context) {
    Clipboard.setData(ClipboardData(text: _model.Description));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//              print(jsonEncode(_model));
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
                    // 通知前面修改数据
//                    eventBus.fire(new RemoveLike(_model.Guid)); // 先发
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
                    // 通知前面修改数据
//                    eventBus.fire(new AddNewLike(_model.Guid)); // 先发
                  }
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
                }).catchError((err) {
                  print(err);
                  if (mounted) {
                    setState(() {
                      _btnEnable = true;
                    });
                  }
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
                ' (${widget.model.Likes})  ',
                style: TextStyle(
                  color: Color.fromRGBO(142, 142, 142, 1),
                ),
              )
            ],
          ),
        ),
        _isWeChatInstalledTag == true
            ? InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return ShareDialog(
                        okCallback: () async {
                          // 分享朋友圈
                          setState(() {
                            _isShareing = true;
                          });
                          ListObjectsModel model = _model;
                          String Guid = model.Guid;
                          await CustomerApi()
                              .GetDQMomentSharePicture(context, Guid)
                              .then((val) {
                            if (val == null) {
                              setState(() {
                                _isShareing = false;
                              });
                              return;
                            } else {
                              setState(() {
                                _isShareing = false;
                              });
//                              print(val.data.imageUrl);
                              _shareWeixinTimeline(val.data.imageUrl);
                            }
                          }).catchError((error) {
                            setState(() {
                              _isShareing = true;
                            });
                            print(error);
                          });
                        },
                        otherCallback: () async {
                          setState(() {
                            _isShareing = true;
                          });
                          // 分享给好友
                          ListObjectsModel model = _model;
                          String Guid = model.Guid;
                          await CustomerApi()
                              .GetDQMomentSharePicture(context, Guid)
                              .then((val) {
                            if (val == null) {
                              setState(() {
                                _isShareing = true;
                              });
                              return;
                            } else {
//                              print(val.data.imageUrl);
                              _shareWeixinSession(val.data.imageUrl);
                            }
                          }).catchError((error) {
                            setState(() {
                              _isShareing = true;
                            });
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
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        '（分享） ',
                        style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Text(''),
      ],
    );
  }

  /*
  * 微信分享到朋友圈
  * */
  _shareWeixinTimeline(String url) async {
    fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;
    var des = _model.Description;

//    print(url);
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
    var des = _model.Description;

//    print(url);
    var model = new fluwx.WeChatShareImageModel(
      image: url,
      thumbnail: url,
      transaction: url,
      scene: scene,
      description: '',
    );
    fluwx.shareToWeChat(model);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(jsonEncode(widget.model));
    setState(() {
      _model = widget.model;
    });

    _getWeChatInstalledTag();
    _registerAction();
  }

  _registerAction() async {
    fluwx.responseFromShare.listen((data) {
      print('分享回调');
      print(data.errCode);
      setState(() {
        _isShareing = false;
      });
    });
  }

  //监听Bus events
  void _listen() {
    eventBus.on<StopLoading>().listen((event) {
      if (mounted) {
        setState(() {
          _isShareing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Scaffold(
      backgroundColor: Colors.white,
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
          '动态详情',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            controller: _listControl,
            children: <Widget>[
              _topWidget(),
              Container(
                height: 10,
                margin: EdgeInsets.only(top: 15, bottom: 10),
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
              Padding(
                padding: EdgeInsets.only(top: 21, left: 15, bottom: 15),
                child: Text(
                  '全部评论（${_model.Comments.length}）',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _bottomWidget(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Color.fromRGBO(245, 245, 245, 1),
                child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        focusNode: _contentFocusNode,
                        controller: _inputControl,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          icon: Image.asset('assets/icon_address_edit.png'),
                          hintText: '我也来说两句...',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(133, 134, 136, 1),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var txt = _inputControl.text;

                        List list = txt.split(' ');

                        if (list.length > 1 &&
                            txt.contains(list[0]) &&
                            _ReplyToGuid.length > 0) {
                          //  回复
                          var str = '';
                          for (var i = 1; i < list.length; i++) {
                            str += list[i];
                          }

                          if (str.length == 0) {
                            Fluttertoast.showToast(
                                backgroundColor: Color(0xFF666666),
                                msg: '请填写内容',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER);
                            return;
                          } else {
                            Map map = {
                              'Content': str,
                              'GroupGuid': _model.Guid,
                              'ReplyToGuid': _ReplyToGuid,
                            };
                            CustomerApi().AddNewComment(context, map).then((e) {
                              if (e['Success'] == true) {
                                setState(() {
                                  _inputControl.text = '';
                                });
                                _contentFocusNode.unfocus();

                                Fluttertoast.showToast(
                                    backgroundColor: Color(0xFF666666),
                                    msg: "回复成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER);
//                              _listControl.jumpTo(0);

                                List<CommentsModel> list = [];
                                e['Data'].forEach((e) {
                                  list.add(CommentsModel.fromJson(e));
                                });
                                setState(() {
                                  _model.Comments = list;
                                });
                              }
                            }).catchError((err) {
                              print(err);
                            });
                          }
                        } else {
                          var str = txt.trim();
                          if (str.length == 0) {
                            Fluttertoast.showToast(
                                backgroundColor: Color(0xFF666666),
                                msg: "请填写内容",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER);
                            setState(() {
                              _inputControl.text = '';
                            });
                          } else {
                            Map map = {
                              'Content': str,
                              'GroupGuid': _model.Guid,
                            };
                            CustomerApi().AddNewComment(context, map).then((e) {
                              if (e['Success'] == true) {
                                setState(() {
                                  _inputControl.text = '';
                                });
                                _contentFocusNode.unfocus();

                                Fluttertoast.showToast(
                                    backgroundColor: Color(0xFF666666),
                                    msg: "发送成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER);
                                _listControl.jumpTo(0);

                                List<CommentsModel> list = [];
                                e['Data'].forEach((e) {
                                  list.add(CommentsModel.fromJson(e));
                                });
                                setState(() {
                                  _model.Comments = list;
                                });
                              }
                            }).catchError((err) {
                              print(err);
                            });
                          }
                        }
                      },
                      child: Container(
                        height: 45,
//                        color: Colors.red,
                        child: Center(
                          child: Text(
                            '发送',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(35, 119, 195, 1),
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
          Positioned(
            child: _isShareing == true
                ? LoadingWidget(
                    title: '分享中...',
                  )
                : Text(''),
          ),
        ],
      ),
    );
  }

  Widget _bottomWidget() {
    if (_model.Comments.length == 0) {
      return Text('尚无评论');
    } else {
      List<Widget> _commentListWidget = [];
//      print(_model);
      _model.Comments.map((e) {
//        print(e);
      })
          .toList();

      for (var i = 0; i < _model.Comments.length; i++) {
        _commentListWidget
            .add(commentWidget(model: _model.Comments[i], index: i));
      }

      return Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _commentListWidget,
        ),
      );
    }
  }

  /*
  * 评论主体
  * */
  Widget commentWidget({
    CommentsModel model,
    List list,
    int index,
  }) {
    if (list == null) {
      return Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
        ),
//        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(231, 231, 231, 1), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    '${model.StoreCustomerHeaderImage}?imageView2/0/w/45/h/45',
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '${model.StoreCustomerName}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(255, 173, 78, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          model.AtTheTop == 1
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
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4, right: 15),
                        child: Text(
                            '${DateUtil.formatDateMs(((model.CreatedOn - 621355968000000000) ~/ 10000), format: 'yyyy-MM-dd HH:mm')}'),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onLongPress: () {
//                    print(jsonEncode(model));
                    setState(() {
                      _ReplyToGuid = model.Guid;
                    });
                    _inputControl.text = '@${model.StoreCustomerName}: ';
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
//                    color: Colors.yellow,
                    child: Text(
                      '${model.Content}',
                      softWrap: true,
//                      maxLines: 4,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (model.AtTheTop == 1) {
                      // 取消置顶
                      CustomerApi().SetCommentAtTop(context,
                          {'AtTheTop': '0', 'Guid': model.Guid}).then((e) {
                        if (e['Success'] == true) {
                          List<CommentsModel> list = [];
                          e['Data'].forEach((e) {
                            list.add(CommentsModel.fromJson(e));
                          });
                          setState(() {
                            _model.Comments = list;
                          });
                        }
                      }).catchError((err) {
                        print(err);
                      });
                    } else {
                      // 设为置顶
                      var dialog = CupertinoAlertDialog(
                        content: Text(
                          "您确定设为置顶吗?",
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
                            onPressed: () async {
                              Navigator.pop(context);
                              CustomerApi().SetCommentAtTop(context, {
                                'AtTheTop': '1',
                                'Guid': model.Guid
                              }).then((e) {
                                if (e['Success'] == true) {
                                  List<CommentsModel> list = [];
                                  e['Data'].forEach((e) {
                                    list.add(CommentsModel.fromJson(e));
                                  });
                                  setState(() {
                                    _model.Comments = list;
                                  });
                                }
                              }).catchError((err) {
                                print(err);
                              });
                            },
                          ),
                        ],
                      );

                      showDialog(context: context, builder: (_) => dialog);
                    }
                  },
                  child: model.AtTheTop == 1
                      ? Padding(
                          padding:
                              EdgeInsets.only(right: 15, bottom: 10, top: 10),
                          child: Text(
                            '取消置顶',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(35, 119, 195, 1),
                            ),
                          ),
                        )
                      : Padding(
                          padding:
                              EdgeInsets.only(right: 15, bottom: 10, top: 10),
                          child: Text(
                            '设为置顶',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(35, 119, 195, 1),
                            ),
                          ),
                        ),
                ),
                commentWidget(list: model.Replies),
              ],
            ),
          ],
        ),
      );
    } else {
      if (list.length > 0) {
        List<Widget> _listReplies = [];
//        print(list);
        list.map((e) {
          var time = DateUtil.formatDateMs(
              ((e['CreatedOn'] - 621355968000000000) ~/ 10000),
              format: 'yyyy-MM-dd HH:mm');
          return _listReplies.add(Container(
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(231, 231, 231, 1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          '${e['StoreCustomerHeaderImage']}?imageView2/0/w/45/h/45',
                        ),
                      ),
                    ),
                  ),
                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 125,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '${e['StoreCustomerName']}',
                              ),
                              margin: EdgeInsets.only(top: 8),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(time),
                            ),
                          ],
                        ),
                      ),
                      Container(
//                        height: 60,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: EdgeInsets.only(left: 14),
//                color: Colors.red,
                        child: Text(
                          '${e['Content']}',
                          softWrap: true,
//                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        }).toList();
        return Column(
          children: _listReplies,
        );
      } else {
        return Text('');
      }
    }
  }

  Widget _buildTimeline() {
    var text = DateUtil.formatDateMs(
        ((widget.model.UpdatedOn - 621355968000000000) ~/ 10000),
        format: 'MM-dd');
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

  /*
  * 上部视图
  * */
  Widget _topWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16),
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

  Widget _buildContentTextArea() {
    var txt = widget.model.Description;
    var topicName = widget.model.GroupName;
    List list = txt.split('#');

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
                fontSize: 14,
                color: Color.fromRGBO(255, 173, 76, 1),
              ),
              children: [
                TextSpan(
                  text: list.length > 1 ? '$desc' : widget.model.Description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(21, 21, 21, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
        ],
      ),
    );
  }

  Widget _buildContentImageArea() {
//    print(widget.model.ProductList[0].PictureList);
    List<Widget> listWidget = [];
    for (var i = 0; i < widget.model.ProductList.length; i++) {
      listWidget.add(_imgsWidget(widget.model.ProductList[i], i));
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
  Widget _imgsWidget(ProductListModel model, int index) {
    double width = 0.0;
    double media_w = MediaQuery.of(context).size.width - 55.0 - 10.0;
    List list = widget.model.ProductList;
    if (list.length <= 4) {
      width = media_w / 2 - 5;
    } else {
      width = media_w / 3 - 5;
    }

    return ProductThumbnail(
      width: width,
      list: widget.list,
      index: index,
      picStr: model.PictureList.length > 0 ? model.PictureList[0] : '',
      videoStr: model.VideoUrl,
      price: _deducePrice(model.Price, model.MinPrice, model.MaxPrice),
      model: widget.model,
      storeInfomodel: widget.storeInfoModel,
    );
  }
}
