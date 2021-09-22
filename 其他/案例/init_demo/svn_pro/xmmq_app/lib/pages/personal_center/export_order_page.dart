import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:date_format/date_format.dart';

import '../../serviceapi/customerapi.dart';
import '../../widgets/loading_widget.dart';

class ExportOrderPage extends StatefulWidget {
  @override
  _ExportOrderPageState createState() => _ExportOrderPageState();
}

class _ExportOrderPageState extends State<ExportOrderPage> {
  int _orderType = 0; // 订单状态,当前默认0
  int _timeTpye = 0; // 订单时间段,默认0
  String _selectedStartDateStr = ''; // 选中日期
  String _selectedEndDateStr = ''; // 选中日期
  bool _showLoadingTag = false; //  加载中状态

  //调起日期选择器
  _showStartDatePicker() {
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Text('确定', style: TextStyle(color: Colors.red)),
          cancel: Text('取消', style: TextStyle(color: Colors.cyan)),
        ),
        minDateTime: DateTime.parse("1980-05-21"),
        maxDateTime: DateTime.parse("2119-05-21"),
        initialDateTime: DateTime.now(),
        dateFormat: "yyyy/MMMM/dd", //只包含年、月、日
        pickerMode: DateTimePickerMode.datetime,
        locale: DateTimePickerLocale.zh_cn, onCancel: () {
      debugPrint("onCancel");
    }, onConfirm: (dateTime, List<int> index) {
      setState(() {
        _selectedStartDateStr = formatDate(dateTime, [yyyy, '/', mm, '/', dd]);
      });
    });
  }

  //调起日期选择器
  _showEndDatePicker() {
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Text('确定', style: TextStyle(color: Colors.red)),
          cancel: Text('取消', style: TextStyle(color: Colors.cyan)),
        ),
        minDateTime: DateTime.parse("1980-05-21"),
        maxDateTime: DateTime.parse("2119-05-21"),
        initialDateTime: DateTime.now(),
        dateFormat: "yyyy/MMMM/dd", //只包含年、月、日
        pickerMode: DateTimePickerMode.datetime,
        locale: DateTimePickerLocale.zh_cn, onCancel: () {
      debugPrint("onCancel");
    }, onConfirm: (dateTime, List<int> index) {
      setState(() {
        _selectedEndDateStr = formatDate(dateTime, [yyyy, '/', mm, '/', dd]);
      });
    });
  }

  /*
  * 一键导出订单
  * */
  _exportOrder() async {
    setState(() {
      _showLoadingTag = true;
    });

    var ExportOrderStatus = 'all';
    if (_orderType == 0) {
      ExportOrderStatus = 'all';
    } else if (_orderType == 1) {
      ExportOrderStatus = 'waitaction';
    } else {
      ExportOrderStatus = 'readyforship';
    }

    var ExportOrderDateType = 'today';
    if (_timeTpye == 0) {
      ExportOrderDateType = 'today';
    } else if (_timeTpye == 1) {
      ExportOrderDateType = 'thismonth';
    } else if (_timeTpye == 2) {
      ExportOrderDateType = 'halfyear';
    } else {
      ExportOrderDateType = 'oneyear';
    }

    _selectedStartDateStr =
        _selectedStartDateStr == '' ? '' : _selectedStartDateStr;
    _selectedEndDateStr = _selectedEndDateStr == '' ? '' : _selectedEndDateStr;
//    print(_selectedStartDateStr);
//    print(_selectedEndDateStr);
    CustomerApi()
        .ExportDQOrders(context, ExportOrderDateType, _selectedEndDateStr,
            _selectedStartDateStr, ExportOrderStatus)
        .then((val) {
      setState(() {
        _showLoadingTag = false;
      });
      if (val['Success'] == true) {
        // 显示选择提示框
        var dialog = CupertinoAlertDialog(
          content: Text(
            "订单已经导出,请选择?",
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text("复制链接"),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: val['Data']));
                Fluttertoast.showToast(
                    backgroundColor: Color(0xFF666666),
                    msg: "已经复制~",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER);
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text("下载"),
              onPressed: () async {
//                Dio dio = Dio();
//                CancelToken cancelToken = CancelToken();
//                try {
//                  Response response = await dio.download(
//                      val['Data'], './ok.xlsx',
//                      cancelToken: cancelToken);
//                  if (response.statusCode == 200) {
//                    Fluttertoast.showToast(
//                        backgroundColor: Color(0xFF666666),
//                        msg: "下载请求成功!",
//                        toastLength: Toast.LENGTH_LONG,
//                        gravity: ToastGravity.CENTER);
//                  }
//                } catch (e) {
//                  print(e);
//                }
                if (await canLaunch(val['Data'])) {
                  await launch(val['Data']);
                } else {
                  throw 'Could not launch ${val['Data']}';
                }
              },
            ),
          ],
        );

        showDialog(context: context, builder: (_) => dialog);
      } else {
        setState(() {
          _showLoadingTag = false;
        });
        Fluttertoast.showToast(
            backgroundColor: Color(0xFF666666),
            msg: "订单导出失败,请稍后再试!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
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
          '一键导出订单',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 5, left: 10),
                      child: Text(
                        '请选择订单状态',
                        style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Wrap(
                        spacing: 10,
                        children: <Widget>[
                          _wrapItemWidget('全部', 0),
                          _wrapItemWidget('未支付', 1),
                          _wrapItemWidget('已支付', 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 1,
                      color: Color.fromRGBO(221, 221, 221, 1),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 5, left: 10),
                      child: Text(
                        '请选择时间段',
                        style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Wrap(
                        spacing: 10,
                        children: <Widget>[
                          _wrapTimeWidget('当日', 0),
                          _wrapTimeWidget('当月', 1),
                          _wrapTimeWidget('半年', 2),
                          _wrapTimeWidget('一年内', 3),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 1,
                      color: Color.fromRGBO(221, 221, 221, 1),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 5, left: 5),
                      child: Text(
                        ' 请选择具体时间',
                        style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                     开始时间
                        _startTimerPickerWidget(),
                        Container(
                          width: 12,
                          height: 1,
                          margin: EdgeInsets.only(top: 45),
                          color: Color.fromRGBO(187, 187, 187, 1),
                        ),
//                结束时间
                        _endTimerPickerWidget(),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: _exportOrder,
                child: Container(
                  height: 49,
                  color: Color.fromRGBO(255, 175, 76, 1),
                  child: Center(
                    child: Text(
                      '一键导出订单',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _showLoadingTag == true
              ? Positioned(
                  child: LoadingWidget(
                    title: '订单导出中...',
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  /*
  * 开始时间
  * */
  Widget _startTimerPickerWidget() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 5, left: 10),
      width: 159,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '开始时间',
            ),
            InkWell(
              onTap: () async {
                _showStartDatePicker();
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                height: 44,
                width: 159,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.access_time,
                        color: Color.fromRGBO(187, 187, 187, 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        _selectedStartDateStr,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  * 结束时间
  * */
  Widget _endTimerPickerWidget() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      margin: EdgeInsets.only(right: 10),
      width: 159,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('结束时间'),
            InkWell(
              onTap: () async {
                _showEndDatePicker();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                margin: EdgeInsets.only(top: 10),
                height: 44,
                width: 159,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.access_time,
                        color: Color.fromRGBO(187, 187, 187, 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        _selectedEndDateStr,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  * 返回一个订单状态标签
  * */
  Widget _wrapItemWidget(String txt, int num) {
    return InkWell(
      onTap: () {
        setState(() {
          _orderType = num;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 110,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: _orderType == num
              ? Color.fromRGBO(255, 237, 213, 1)
              : Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                fontSize: 14,
                color: _orderType == num ? Colors.red : Colors.black),
          ),
        ),
      ),
    );
  }

  /*
  * 返回一个订单时间段标签
  * */
  Widget _wrapTimeWidget(String txt, int num) {
    return InkWell(
      onTap: () {
        setState(() {
          _timeTpye = num;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 110,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: _timeTpye == num
              ? Color.fromRGBO(255, 237, 213, 1)
              : Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 14,
              color: _timeTpye == num ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
