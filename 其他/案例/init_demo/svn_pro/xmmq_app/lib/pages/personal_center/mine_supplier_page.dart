/*
* 我的供应商
* */

import 'package:flutter/material.dart';

import 'supplier_page.dart';
import 'wholesaler_page.dart';
import '../../serviceapi/customerapi.dart';
import '../../widgets/loading_widget.dart';

class MineSupplierPage extends StatefulWidget {
  @override
  _MineSupplierPageState createState() => _MineSupplierPageState();
}

class _MineSupplierPageState extends State<MineSupplierPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  int _currentTab = 0; // 当前Tab默认0，批发商
  bool _isShowTab = false; // 是否展示tab
  bool _showLoadingTag = true; //  加载中状态

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getListData();

    // TODO: implement initState
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() async {
        switch (_controller.index) {
          case 0:
            setState(() {
              _currentTab = 0;
            });
            break;
          case 1:
            setState(() {
              _currentTab = 1;
            });
        }
      });
  }

  /*
  * 获取列表数据
  * */
  _getListData() async {
    await CustomerApi().GetVendorCategoryList(context).then((e) {
      List list = e['Data'];
      if (list.length > 0) {
        setState(() {
          _isShowTab = true;
          _showLoadingTag = false;
        });
      } else {
        setState(() {
          _isShowTab = false;
          _showLoadingTag = false;
        });
      }
    }).catchError((e) {
      setState(() {
        _isShowTab = false;
        _showLoadingTag = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget retutnBuildWidget() {
    if (_isShowTab == true) {
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
            '我的供货商',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Color.fromRGBO(255, 175, 76, 1),
            indicatorWeight: 0.1,
            labelPadding: EdgeInsets.zero,
            controller: _controller,
            tabs: <Widget>[
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 44,
                  color: _currentTab == 0
                      ? Color.fromRGBO(255, 175, 76, 1)
                      : Colors.white,
                  child: Center(
                    child: Text(
                      '批发商',
                      style: TextStyle(
                          color:
                              _currentTab == 0 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 44,
                  color: _currentTab == 1
                      ? Color.fromRGBO(255, 175, 76, 1)
                      : Colors.white,
                  child: Center(
                    child: Text(
                      '供货商家',
                      style: TextStyle(
                          color:
                              _currentTab == 1 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            WholesalerPage(),
            SupplierPage(),
          ],
        ),
      );
    } else {
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
            '我的供货商',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: SupplierPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoadingTag == true) {
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
            '我的供货商',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        body: Center(
          child: LoadingWidget(title: ' 加载中...'),
        ),
      );
    } else {
      return retutnBuildWidget();
    }
  }
}
