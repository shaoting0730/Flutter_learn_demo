/*
* 批发商
* */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../widgets/search_bar.dart';
import '../../utils/customDialog/edit_dialog.dart';
import '../../serviceapi/customerapi.dart';
import '../../models/api/vendorCategoryList.dart';
import '../../models/api/vendors.dart';
import '../../models/api/supplierProduct.dart';
import '../../widgets/loading_widget.dart';
import '../../models/api/goods.dart';
import '../store_dynamic/publish_activity.dart';
import '../../utils/utils.dart';

class WholesalerPage extends StatefulWidget {
  @override
  _WholesalerPageState createState() => _WholesalerPageState();
}

class _WholesalerPageState extends State<WholesalerPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Map _VendorCategoryMap; //   得到分组信息
  Map _VendorCategoryMap_new; //   得到分组信息
  bool _showLoadingTag = true; //  加载中状态

  Map _VendorsModel; // 得到供应商名字信息
  Map _SupplierProductModel; // 列表数据

  int _PageIndex = 0; // 默认加载第0页

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
    _getNameData(); // 获取分类name 和供应商name
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      _getListData();
    });
  }

  List<int> mList = [];
  List<ExpandStateBean> expandStateList = [];

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpand;
        }
      });
    });
  }

  /*
  * 获取名字相关数据
  * */
  _getNameData() async {
    await CustomerApi().GetVendorCategoryList(context).then((e) {
      setState(() {
        e['Data'].forEach((e) {
          e['Products'] = [];
        });
        _VendorCategoryMap = e;
      });

      CustomerApi().LoadAllVendors(context).then((e1) {
        setState(() {
          _VendorsModel = e1;
        });

//        print(e1);
      }).catchError((e) {});
    }).catchError((e) {});
  }

  /*
  * 获取列表数据
  * */
  _getListData() async {
    CustomerApi().SearchVendorProduct(context, {
//      "PageIndex": _PageIndex,
//      "PageSize": 1,
    }).then((e) {
      setState(() {
        _SupplierProductModel = e;
      });
      // 制造新的数据源
      print(jsonEncode(_VendorCategoryMap));
      print(jsonEncode(_VendorsModel));
//      print(jsonEncode(e));
//      print(e.data.listObjects);
//
//      print('+++++++');
//      print(e['Data']['ListObjects']);
      e['Data']['ListObjects'].forEach((e) {
//        print('_VendorCategoryMap ${_VendorCategoryMap}');
        for (var i = 0; i < _VendorCategoryMap['Data'].length; i++) {
//          print('---${e.vendorCategoryGuid}');
//          print(_VendorCategoryMap.Data[i].Guid);
          if (e['VendorCategoryGuid'] ==
              _VendorCategoryMap['Data'][i]['Guid']) {
            setState(() {
              _VendorCategoryMap['Data'][i]['Products'].add(e);
            });
          } else {
//            print(_VendorCategoryMap['Data'][i]['CategoryName']);
            if (_VendorCategoryMap['Data'][i]['CategoryName'] == '自营商品') {
              setState(() {
                _VendorCategoryMap['Data'][i]['Products'].add(e);
              });
            }
          }

          if (e['VendorGuid'] == _VendorsModel['Data'][0]['Guid']) {
            setState(() {
              _VendorCategoryMap['Data'][i]['VendorName'] =
                  _VendorsModel['Data'][0]['VendorName'];
            });
          } else {
            setState(() {
              _VendorCategoryMap['Data'][i]['VendorName'] = '未知供应商';
            });
          }
        }
      });

//      print(_VendorCategoryMap);
      mList = new List();
      expandStateList = new List();
      for (int i = 0; i < _VendorCategoryMap['Data'].length; i++) {
        setState(() {
          mList.add(i);
          expandStateList.add(
            ExpandStateBean(
                i,
                false,
                _VendorCategoryMap['Data'][i]['Products'],
                '${_VendorCategoryMap['Data'][i]['VendorName']}',
                '${_VendorCategoryMap['Data'][i]['CategoryName']}'),
          );
        });
      }

      setState(() {
        _showLoadingTag = false;
        _VendorCategoryMap_new = _VendorCategoryMap;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _showLoadingTag = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          EasyRefresh(
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
            loadMore: () async {},
            onRefresh: () async {
              setState(() {
                _showLoadingTag = true;
              });
              _getNameData(); // 获取分类name 和供应商name
              Future.delayed(Duration(milliseconds: 200)).then((e) {
                _getListData();
              });
            },
            child: SingleChildScrollView(
              child: ExpansionPanelList(
                expansionCallback: (index, bol) {
                  _setCurrentIndex(index, bol);
                },
                children: mList.map((index) {
                  return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 5,
                                  height: 25,
                                  color: Color.fromRGBO(253, 159, 60, 1),
                                ),
                                Text('  ${expandStateList[index].CategoryName}')
                              ],
                            ),
                            expandStateList[index].isOpen == true
                                ? Text('收起')
                                : Text('展开')
                          ],
                        );
                      },
                      body: _childItemBuild(
                          expandStateList[index].VendorName ?? '',
                          expandStateList[index].list),
                      isExpanded: expandStateList[index].isOpen);
                }).toList(),
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

  /*
  *  编辑/上架 按钮 点击
  * */
  _editAction(e) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return EditDialog(
          map: e,
          okCallback: () async {
            setState(() {
              _showLoadingTag = true;
            });
            _getNameData(); // 获取分类name 和供应商name
            Future.delayed(Duration(milliseconds: 200)).then((e) {
              _getListData();
            });
          },
          dismissCallback: () {
            print("取消了");
          },
        );
      },
    );
  }

  /*
  * 推导出价格
  * */
  String _deducePrice(price, minPrice, maxPrice) {
    if (price == maxPrice && price == 0.0) {
      return '¥0';
    } else if (maxPrice == minPrice && price != 0.0) {
      return '¥ ${Utils.stringFormat(price.toString())}';
    } else {
      return '¥${Utils.stringFormat(minPrice.toString())}-¥${Utils.stringFormat(minPrice.toString())}';
    }
  }

  Widget _childItemBuild(String vendorName, List list) {
    List<Widget> _listWidget = list.map((e) {
//      print('==== ${e}');
      return Container(
        margin: EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              '${e['PictureList'][0]}?imageView2/0/w/250/h/250',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            Container(
//              color: Colors.yellow,
              margin: EdgeInsets.only(left: 5),
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${e['ProductName']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '¥${Utils.stringFormat(e['VendorPrice'].toString())}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(238, 244, 255, 1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    '$vendorName',
                                    style: TextStyle(
                                      color: Color.fromRGBO(108, 169, 221, 1),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            e['MyGuid'].length == 0
                                ? InkWell(
                                    onTap: () => this._editAction(e),
                                    child: Container(
                                      width: 64,
                                      height: 33,
                                      color: Color.fromRGBO(255, 175, 76, 1),
                                      margin: EdgeInsets.only(right: 0),
                                      child: Center(
                                        child: Text(
                                          '上架',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () => _editAction(e),
                                    child: Container(
                                      width: 64,
                                      height: 33,
                                      margin: EdgeInsets.only(right: 0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '编辑',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        e['MyGuid'].length != 0
                            ? Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      _deducePrice(e['MyPrice'],
                                          e['MyMinPrice'], e['MyMaxPrice']),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 237, 213, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        '我的售价',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(232, 102, 31, 1),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _listWidget,
    );
  }
}

// 控制开合
class ExpandStateBean {
  var isOpen; // 是否打开
  var index; // 下标
  List list;
  String VendorName;
  String CategoryName;
  ExpandStateBean(
      this.index, this.isOpen, this.list, this.VendorName, this.CategoryName);
}
