/*
* 消息中心
* */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xmmq_app/widgets/loading_widget.dart';
import '../store_dynamic/activity_context.dart';

import '../../utils/event_bus.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/all_comments_model.dart';
import '../../models/api/customer.dart';

class MessageCenter extends StatefulWidget {
  @override
  _MessageCenterState createState() => _MessageCenterState();
}

class _MessageCenterState extends State<MessageCenter> {
  bool _switchValue = true;
  bool _loadingTag = true;
  int _pageIndex = 0;
  bool _pushTag = false;
  bool _getPushData = false;
  AllCommentModel _model;
  List<ListObjects> _dataSource = [];
  String _imgUrl = '';
  StoreInfoModel _storeInfoModel;

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _switchValue = CustomerApi().getDisableComment() == 0 ? true : false;
    });
    if (_switchValue == true) {
      _getCommentData();
    } else {
      setState(() {
        _loadingTag = false;
      });
    }
    _getStoreInfo();
  }

  _getStoreInfo() async {
    // 获取店的信息
    await CustomerApi().RetrieveStoreInfo(context, false).then((data) {
      var StoreGuid = data.StoreGuid;
      CustomerApi().LoadUserBind(context, StoreGuid).then((data) {
        setState(() {
          _imgUrl = data.WechatThumber;
        });
      });
      setState(() {
        _storeInfoModel = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  _getCommentData() async {
    CustomerApi().StoreRecentComment(context, {
      'pageIndex': _pageIndex,
      'pageSize': 20,
    }).then((e) {
      _model = e;
      setState(() {
        _loadingTag = false;
        _dataSource += e.data.listObjects;
      });
    }).catchError((err) {
      setState(() {
        _loadingTag = false;
      });
    });
  }

  Widget _topWidget() {
    return Container(
      height: 50,
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              '评论设置',
              style: TextStyle(
                color: Color.fromRGBO(135, 135, 135, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: <Widget>[
                Text(
                  _switchValue == true ? '全站评论开启 ' : '全站评论关闭 ',
                  style: TextStyle(
                    color: Color.fromRGBO(135, 135, 135, 1),
                  ),
                ),
                CupertinoSwitch(
                  activeColor: Color.fromRGBO(253, 159, 60, 1),
                  value: _switchValue,
                  onChanged: (e) {
                    setState(() {
                      _switchValue = e;
                    });
//                    print(e);
                    if (e == false) {
                      print('开-> 关');
                      setState(() {
                        _dataSource = [];
                      });

                      CustomerApi().DisableComment(context, 1).then((e) {
                        CustomerApi().LoadUserBind(
                          context,
                          CustomerApi().getStoreGuid(),
                        );
                        eventBus.fire(new DisableComment(1)); // 先发
                      }).catchError((err) {
                        print(err);
                      });
                    } else {
                      print('关-> 开');
                      setState(() {
                        _loadingTag = true;
                      });
                      CustomerApi().DisableComment(context, 0).then((e) {
                        print(e);
                        CustomerApi().LoadUserBind(
                          context,
                          CustomerApi().getStoreGuid(),
                        );
                        eventBus.fire(new DisableComment(0)); // 先发
                      }).catchError((err) {
                        print(err);
                      });
                      _getCommentData();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  *  左部分UI
  * */
  Widget _leftWidget(int index) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(231, 231, 231, 1), width: 1),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            '${_dataSource[index].storeCustomerHeaderImage}' +
                '?imageView2/0/w/250/h/250',
          ),
        ),
      ),
    );
  }

  /*
  *  右部分UI
  * */
  Widget _rightWidget(int index) {
    return Container(
//      height: 103,
      margin: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width - 65,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromRGBO(221, 221, 221, 1),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${_dataSource[index].storeCustomerName}'),
              Container(
                width: 200,
                child: Text(
                  '${_dataSource[index].content}',
                  softWrap: true,
//                    maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  '${DateUtil.formatDateMs(((_dataSource[index].createdOn - 621355968000000000) ~/ 10000), format: 'yyyy-MM-dd HH:mm')}',
                  style: TextStyle(
                    color: Color.fromRGBO(135, 135, 135, 1),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Image.network(
              '${_dataSource[index].thumbernail}',
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        title: _imgUrl.length > 0
            ? Row(
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(231, 231, 231, 1), width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          _imgUrl + '?imageView2/0/w/250/h/250',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      _storeInfoModel.StoreName,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ],
              )
            : Text(''),
      ),
      body: _loadingTag == true
          ? LoadingWidget(
              title: '加载中...',
            )
          : Column(
              children: <Widget>[
                _topWidget(),
                Expanded(
                  child: EasyRefresh(
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
                        _pageIndex++;
                      });
                      _getCommentData();
                    },
                    onRefresh: () async {
                      if (_switchValue == true) {
                        setState(() {
                          _switchValue = true;
                          _loadingTag = true;
                          _pageIndex = 0;
                          _dataSource = [];
                        });
                        _getCommentData();
                      }
                    },
                    child: _dataSource.length == 0
                        ? Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/noData.png',
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Text(
                                  ' 无消息',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: ListView.builder(
                                  itemCount: _dataSource.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 18),
                                      child: InkWell(
                                        onTap: () async {
//                                    print(jsonEncode(_dataSource[index]));
                                          if (_pushTag == false) {
                                            setState(() {
                                              _pushTag = true;
                                            });

                                            await CustomerApi()
                                                .SearchDQProductGroup(context, {
                                              "ProductGroupGuid": [
                                                _dataSource[index].groupGuid
                                              ],
                                              "pageIndex": 0,
                                              "pageSize": 1,
                                            }).then((data) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivityContext(
                                                    list: data.ListObjects,
                                                    model: data.ListObjects[0],
//                                            storeInfoModel: widget.storeInfoModel,
                                                  ),
                                                ),
                                              );
                                              setState(() {
                                                _pushTag = false;
                                              });
                                            }).catchError((error) {
                                              setState(() {
                                                _pushTag = false;
                                              });
                                              print(error);
                                            });
                                          }
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            _leftWidget(index),
                                            _rightWidget(index),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              _pushTag == true
                                  ? Positioned(
                                      child: LoadingWidget(
                                        title: '加载中...',
                                      ),
                                    )
                                  : Text('')
                            ],
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
