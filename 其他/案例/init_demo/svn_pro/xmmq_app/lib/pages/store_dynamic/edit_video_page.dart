/*
* 店主动态- 编辑视频
* */

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../serviceapi/customerapi.dart';
import '../store_main.dart';
import '../../models/api/goods.dart';
import 'edit_product_video_page.dart';

class EditVideoPage extends StatefulWidget {
  final String videoUrl;
  final String price;
  final ListObjectsGoodsModel model;
  final bool isWallTag;

  EditVideoPage({
    Key key,
    @required this.videoUrl,
    @required this.price,
    @required this.model,
    @required this.isWallTag,
  }) : super(key: key);
  @override
  _EditVideoPageState createState() => _EditVideoPageState();
}

class _EditVideoPageState extends State<EditVideoPage> {
  IjkMediaController _videoController = IjkMediaController();
  bool _playingTag = false; //  播放标识 默认未播放

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startVideo();
  }

  /*
  * 播放视频
  * */
  _startVideo() async {
    await _videoController.setNetworkDataSource(widget.videoUrl,
        autoPlay: false);
  }

  /*
  * 编辑按钮响应
  * */
  _editAction(ListObjectsGoodsModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductVideoPage(model: model),
      ),
    );
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
  * 标签页面
  * */
  Widget _tagWidget() {
    List list = widget.model.TagList;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.isWallTag == true
          ? null
          : AppBar(
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
                              '${widget.videoUrl}?vframe/jpg/offset/0|imageView2/1/w/400/h/200'),
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
          Spacer(),
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30, bottom: 15, top: 5),
                  child: Text(
                    '${widget.model.Description}',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
//                  价位
                    Container(
                      width: 120,
                      child: Text(
                        '${widget.price}',
                        softWrap: true,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 175, 76, 1),
                            fontSize: 20),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        //                编辑
                        InkWell(
                          onTap: () => this._editAction(widget.model),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 175, 76, 1),
                            ),
                            width: 78,
                            height: 30,
                            child: Center(
                              child: Text(
                                '编辑',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
//                下架
                        InkWell(
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
                                  onPressed: () =>
                                      this._delete(widget.model.Guid),
                                ),
                              ],
                            );

                            showDialog(
                                context: context, builder: (_) => dialog);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 175, 76, 1),
                            ),
                            width: 78,
                            height: 30,
                            child: Center(
                              child: Text(
                                '下架',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                _tagWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
