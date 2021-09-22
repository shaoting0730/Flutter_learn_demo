/*
*   选择商品
* */

import 'dart:convert';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:xmmq_app/models/api/goodsGroup.dart' as prefix0;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../../widgets/search_bar3.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/goods.dart';
import '../../utils/utils.dart';
import '../../models/api/goodsGroup.dart';
import '../../widgets/search_filter_pane3.dart';
import '../../utils/event_bus.dart';
import '../../widgets/loading_widget.dart';
import '../../bloc/current_type.dart';
import '../goods_manage/look_product_page.dart';
import '../store_dynamic/dynamic_publish.dart';
import '../../models/api/customer.dart';

class SelectProduct extends StatefulWidget {
  @override
  State<SelectProduct> createState() {
    return SelectProductState();
  }
}

class SelectProductState extends State<SelectProduct>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  List<ListObjectsGoodsModel> _dataSource = []; // 数据源
  StoreInfoModel _storeInfoModel;

  Map _groupMap = {}; // 按照时间分类的数据
  bool _selectTag = false; // 是否点击了选择按钮
  List<ListObjectsGoodsModel> _selectList = []; // 选中的model数组
  bool _showLoadingTag = true; //  加载中状态

  bool _publishBtnEnable = true; //  发布按钮可用性
  bool _mergeBtnEnable = true; //  合并按钮可用性
  bool _soldoutBtnEnable = true; //  发布按钮可用性

  List _ProductName = [];
  List _TagList = [];
  String _keywords = '';
  String _imgUrl = '';

  int _PageIndex = 0; //  默认第0页
  int _cellCurrentType = 0;

  var _listControl = ScrollController();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = new AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      _animation =
          new Tween(begin: 0.0, end: MediaQuery.of(context).size.height)
              .animate(_controller)
                ..addListener(() {
                  setState(() {});
                });
    });

    _getPicWall();
  }

  /*
  * 获取照片墙数据
  * */
  _getPicWall() async {
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

    await CustomerApi().SearchDQProduct(context, {
      "ProductName": _ProductName,
      "TagList": _TagList,
      "keywords": _keywords,
//      "PageIndex": _PageIndex,
//      "PageSize": 21,
    }).then((data) {
      setState(() {
        _showLoadingTag = false;
        _dataSource += data.ListObjects;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  /*
  * 批量下架
  * */
  _soldOutAction(List<ListObjectsGoodsModel> list) async {
//    list.forEach((e) {
//      print(e.Description);
//    });
    if (list.length < 1) {
      Fluttertoast.showToast(
          backgroundColor: Color(0xFF666666),
          msg: "请至少选择1个下架对象",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      return;
    }
    var paramsList = [];
    list.forEach((e) {
      paramsList.add(e.Guid);
    });
    CustomerApi().RemoveDQProduct(context, paramsList).then((e) {
      if (e['Success'] == true) {
        setState(() {
          _groupMap = {};
          _selectTag = false;
          _selectList = [];
          _dataSource = [];
          _PageIndex = 0;
          _showLoadingTag = true;
        });
        _getPicWall();
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
  * 筛选点击
  * */
  void _onPressSearchFilter() {
    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
//    this._overlayEntry = this._createOverlayEntry();
//    Overlay.of(context).insert(this._overlayEntry);
  }

  //监听Bus events
  void _listen() {
    eventBus.on<ChangeType>().listen((event) {
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        if (mounted) {
          setState(() {
            _cellCurrentType = event.tag;
          });
        }
      });
    });

    eventBus.on<StartLoading>().listen((event) {
      if (event.tag == true) {
        if (mounted) {
          setState(() {
            _showLoadingTag = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _showLoadingTag = false;
          });
        }
      }
    });

    eventBus.on<GoPicWall>().listen((event) {
      if (mounted) {
        setState(() {
          _selectTag = false;
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _listen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/previous_page.png'),
        ),
        title: Text(
          '选择商品',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SearchBar(
                  needSelectTag: true,
                  selectTag: _selectTag,
                  onFilterPressed: _onPressSearchFilter,
                  inputBack: (e) {
                    Map map = {};
                    map['ProductName'] = [];
                    map['TagList'] = [];
                    map['keywords'] = e;
                    setState(() {
                      _ProductName = [];
                      _TagList = [];
                      _keywords = e;
                      _dataSource = [];
                      _showLoadingTag = true;
                    });
                    _getPicWall();
                  },
                  onSelectPressed: () {
//                  eventBus.fire(new IsPicWall(_selectTag)); // 先发
                    if (_selectTag == true) {
                      setState(() {
                        _publishBtnEnable = true;
                        _mergeBtnEnable = true;
                        _soldoutBtnEnable = true;
                        _selectList = [];
                      });
                      eventBus.fire(new WallCancelSelect(false)); // 先发
                    }
                    setState(() {
                      _selectTag = !_selectTag;
                    });
                  },
                ),
                _buildPictureWallArea(),
              ],
            ),
          ),
          // 下拉框
          Container(
            height: _animation == null ? 0 : _animation.value,
            width: MediaQuery.of(context).size.width,
            child: SearchFilterPane(
              isPicWall: true,
              onClearPressed: () async {
                eventBus.fire(new CancelSelect(true)); // 先发
                // 获取店主动态
                setState(() {
                  _ProductName = [];
                  _TagList = [];
                  _keywords = '';
                  _dataSource = [];
                  _PageIndex = 0;
                  _showLoadingTag = true;
                });
                _getPicWall();
                _controller.reverse();
              },
              onSearchPressed: (topic, tag, txt, isOther) async {
//              if (isOther == true) {
//                print('搜索其他');
//              }
                // 获取店主动态
                setState(() {
                  _ProductName = topic;
                  _TagList = tag;
                  _keywords = txt;
                  _dataSource = [];
                  _showLoadingTag = true;
                });
                _getPicWall();
                _controller.reverse();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                if (_selectList.length == 0) {
                  return;
                }
                Navigator.pop(context, _selectList);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: _selectList.length == 0
                    ? Color.fromRGBO(254, 208, 121, 1)
                    : Color.fromRGBO(255, 198, 63, 1),
                child: Center(
                  child: Text(
                    '选 择(${_selectList.length})',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          _showLoadingTag == true
              ? Positioned(
                  child: LoadingWidget(title: '加载中...'),
                )
              : Text('')
        ],
      ),
    );
  }

  Widget _buildPictureWallArea() {
    return Expanded(
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
            _PageIndex++;
          });
          _getPicWall();
        },
        onRefresh: () async {
          Provider.of<CurrentTypeBloc>(context).changeCurrentType(0);
          setState(() {
            _groupMap = {};
            _PageIndex = 0;
            _dataSource = [];
            _showLoadingTag = true;
            _publishBtnEnable = true;
            _selectList = [];
          });
          _getPicWall();
        },
        child: _buildPictureArea(),
      ),
    );
  }

  Widget _buildPictureArea() {
    List<Widget> listWidget = [];
    for (var i = 0; i < _dataSource.length; i++) {
      listWidget.add(
        ProductThumbnail(
          index: i,
          dataSource: _dataSource,
          currentType: _cellCurrentType,
          storeInfoModel: _storeInfoModel,
          groupMap: _groupMap,
          model: _dataSource[i],
          selectTag: _selectTag,
          callBackModel: (ListObjectsGoodsModel model, bool tag) {
            if (tag == true) {
              // 直接添加即可
              setState(() {
                _selectList.add(model);
              });
            } else {
              // 对比然后删除
              for (var i = 0; i < _selectList.length; i++) {
                if (_selectList[i].Guid == model.Guid) {
                  setState(() {
                    _selectList.removeAt(i);
                  });
                }
              }

              if (_selectList.length == 0) {
                setState(() {
                  _selectList = [];
                  _mergeBtnEnable = true;
                });
                eventBus.fire(new ChangeType(0)); // 先发 让其恢复
              }
            }
            var _picLength = 0;
            var _videoLength = 0;
            // 判断按钮可用性
            if (_selectList.length > 0) {
              for (var i = 0; i < _selectList.length; i++) {
                if (_selectList[i].VideoUrl != null &&
                    _selectList[i].VideoUrl.length > 0) {
                  setState(() {
                    _mergeBtnEnable = false;
                  });
                  // 视频
                  _videoLength += 1;
                  if (_videoLength > 1) {
                    setState(() {
                      _publishBtnEnable = false;
                    });
                  } else {
                    setState(() {
                      _publishBtnEnable = true;
                    });
                  }
                } else {
                  // 图片
                  _picLength += _selectList[i].PictureList.length;

                  if (_picLength > 9) {
                    setState(() {
                      _publishBtnEnable = false;
                    });
                  } else {
                    setState(() {
                      _publishBtnEnable = true;
                    });
                  }
                }
              }
            }

            if (_selectList.length > 1) {
              _selectList.forEach((e) {
                _selectList.forEach((m) {
                  if (e.PictureList.length > 0 &&
                      (m.VideoUrl != null && m.VideoUrl.length > 0)) {
                    setState(() {
                      _publishBtnEnable = false;
                    });
                  }

                  if (m.PictureList.length > 0 &&
                      (e.VideoUrl != null && e.VideoUrl.length > 0)) {
                    setState(() {
                      _publishBtnEnable = false;
                    });
                  }
                });
              });
            }
          },
        ),
      );
    }

    if (_dataSource.length == 0 && _showLoadingTag == false) {
      return Center(
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
              ' 等候店主发新动态',
              style: TextStyle(color: Color(0xFF999999), fontSize: 11),
            ),
          ],
        ),
      );
    } else {
      return ListView(
        controller: _listControl,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 4.0,
              children: listWidget,
            ),
          ),
        ],
      );
    }
  }
}

class ProductThumbnail extends StatefulWidget {
  final ListObjectsGoodsModel model;
  final StoreInfoModel storeInfoModel;
  final Function callBackModel;
  final bool selectTag;
  final Map groupMap;
  final int currentType;
  final List<ListObjectsGoodsModel> dataSource;
  int index;

  ProductThumbnail(
      {Key key,
      @required this.model,
      this.index,
      this.dataSource,
      this.storeInfoModel,
      this.selectTag,
      this.groupMap,
      this.currentType,
      this.callBackModel(ListObjectsGoodsModel model, bool tag)})
      : super(key: key);
  @override
  State<ProductThumbnail> createState() {
    return ProductThumbnailState();
  }
}

class ProductThumbnailState extends State<ProductThumbnail>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool _currentSelectTag = false; // 当前组件是否选中
  int _currentType = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentType = widget.currentType;
    });
  }

  @override
  bool get wantKeepAlive => true;

  /*
  * 推导出价格
  * */
  String _deducePrice(price, minPrice, maxPrice) {
//    print(price);
//    print(minPrice);
//    print(maxPrice);
    if (price == maxPrice && price == 0.0) {
      return '¥ 0';
    } else if (maxPrice == minPrice && price != 0.0) {
//      print(price);
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

  //监听Bus events
  void _listen() {
    eventBus.on<ChangeType>().listen((event) {
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        if (mounted) {
          setState(() {
            _currentType = event.tag;
          });
        }
      });
    });

    eventBus.on<WallCancelSelect>().listen((event) {
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        if (mounted) {
          setState(() {
            _currentSelectTag = event.tag;
            _currentType = 0;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    double screenWidth = MediaQuery.of(context).size.width;

    double pictureWidth = (screenWidth - 15 - 15 - 10 - 10) / 3;
    return InkWell(
      onTap: () async {
        if (widget.model.VideoUrl != null) {
          if (_currentSelectTag == false) {
            eventBus.fire(new ChangeType(1)); // 先发
            // 传true 需要
            widget.callBackModel(widget.model, true);
          } else {
            // 传false 对比删除
            widget.callBackModel(widget.model, false);
          }
          setState(() {
            _currentSelectTag = !_currentSelectTag;
          });
        } else {
          if (_currentSelectTag == false) {
            eventBus.fire(new ChangeType(2)); // 先发
            // 传true 需要
            widget.callBackModel(widget.model, true);
          } else {
            // 传false 对比删除
            widget.callBackModel(widget.model, false);
          }
          setState(() {
            _currentSelectTag = !_currentSelectTag;
          });
        }
      },
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.model.PictureList.length > 0
                      ? widget.model.PictureList[0] +
                          '?imageView2/0/w/230/h/230'
                      : '${widget.model.VideoUrl}?vframe/jpg/offset/0|imageView2/1/w/230/h/230',
                  width: pictureWidth,
                  height: pictureWidth,
                  fit: BoxFit.cover,
                ),
//                商品名
                Container(
                  width: pictureWidth,
                  child: Text(
                    widget.model.Description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
//                价格
                Text(
                  _deducePrice(
                    widget.model.Price,
                    widget.model.MinPrice,
                    widget.model.MaxPrice,
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(231, 56, 63, 1),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5.0,
            right: 5.0,
            child: _currentTypeWidget(widget.model),
          ),
//        是否是合并
          widget.model.PictureList.length > 1
              ? Positioned(
                  bottom: 36,
                  left: 0,
                  child: Container(
                      padding:
                          EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 5),
                      height: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/icon_picture_more.png',
                            height: 15,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            ' ${widget.model.PictureList.length}',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          )
                        ],
                      )),
                )
              : Text(''),
          widget.model.PictureList.length == 0
              ? Positioned(
                  left: pictureWidth / 2 - 19,
                  top: pictureWidth / 2 - 19,
                  child: Image.asset('assets/icon_goods_video.png'),
                )
              : Text(''),
        ],
      ),
    );
  }

  Widget _currentTypeWidget(ListObjectsGoodsModel model) {
//    print(_currentType);
    if (_currentType == 0) {
      return _currentSelectTag == false
          ? Image.asset('assets/icon_detail_add_gray.png')
          : Image.asset('assets/icon_detail_add_yellow.png');
    } else {
      if (model.VideoUrl != null) {
        // 视频
        if (_currentType == 1) {
          return _currentSelectTag == false
              ? Image.asset('assets/icon_detail_add_gray.png')
              : Image.asset('assets/icon_detail_add_yellow.png');
        } else {
          return Text('');
        }
      } else if (model.PictureList.length > 0) {
        // 图片
        if (_currentType == 2) {
          return _currentSelectTag == false
              ? Image.asset('assets/icon_detail_add_gray.png')
              : Image.asset('assets/icon_detail_add_yellow.png');
        } else {
          return Text('');
        }
      } else {
        return _currentSelectTag == false
            ? Image.asset('assets/icon_detail_add_gray.png')
            : Image.asset('assets/icon_detail_add_yellow.png');
      }
    }
  }
}
