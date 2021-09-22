import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import '../routers/application.dart';
import '../serviceapi/customerapi.dart';
import '../widgets/base_page.dart';

class StoreSelectPage extends BasePage {
  @override
  State<StoreSelectPage> createState() {
    return StoreSelectPageState();
  }
}

class StoreSelectPageState extends BasePageState<StoreSelectPage> {
  StoreSelectPageState() : super() {
    title = "店铺选择";
  }

  @override
  void initState() {
    super.initState();
    displayProgressIndicator(true);

    ///CustomerApi().GetMyAccessStores(context);
//    CustomerApi().RetrieveStoreInfo(context, false).then((data) {
//      displayProgressIndicator(false);
//    }).catchError((error) {
//      displayProgressIndicator(false);
//    });
  }

  @override
  Widget pageContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
        child: Column(
          children: <Widget>[
            _buildTitleArea(),
            SizedBox(height: 23),
            Expanded(child: _buildStoreAreaList()),
            _buildApplyButton()
          ],
        ));
  }

  Widget _displayEmptyStore() {}

  Widget _buildTitleArea() {
    return Container(
        padding: const EdgeInsets.fromLTRB(21.5, 0, 21.5, 0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '我自己的小书店',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            )));
  }

  Widget _buildStoreAreaList() {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 0.9,
      children: List.generate(
        10,
        (index) {
          return _buildStoreItem(index);
        },
      ),
    );
  }

  Widget _buildStoreItem(index) {
    return GestureDetector(
      onTap: _onPressStoreItem,
      child: Column(
        children: <Widget>[
          _buildStoreAvatarItem(),
          SizedBox(height: 8),
          _buildStoreName(index)
        ],
      ),
    );
  }

  // Store的名称
  Widget _buildStoreName(index) {
    return Text("汉堡${index + 1}号店",
        style: TextStyle(fontSize: 14, color: Color(0xFF333333)));
  }

  Widget _buildStoreAvatarItem() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Color(0xFFFFAD4C), width: 2.0)),
      ),
    );
  }

  void _onPressStoreItem() {
//    Navigator.pushNamed(context, '/store_main');
    Application.router.navigateTo(context, "./store_main",
        transition: TransitionType.inFromRight);
  }

  Widget _buildApplyButton() {
    return InkWell(
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
                '申请',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
