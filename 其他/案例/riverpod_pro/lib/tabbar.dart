import 'package:flutter/material.dart';
import 'package:fruit/pages/home_page/home_page.dart';
import 'package:fruit/pages/mine_page/mine_page.dart';
import 'package:fruit/widgets/jelly_button.dart';
import 'package:fruit/utils/export_library.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with AutomaticKeepAliveClientMixin {
  int _currenIndex = 0;
  String _angleStr = '';
  final List<Widget> _list = [
    HomePage(),
    MinePage(),
  ];

  itemOnclick(index) {
    setState(() {
      _currenIndex = index;
    });
  }

  _listen() {
    eventBus.on<NotIndex>().listen((event) {
      print(event.index);
      setState(() {
        _angleStr = event.index;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _list[_currenIndex],
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(69),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 首页
              _homePage(),
              //  我的
              _minePage(),
            ],
          ),
        ),
      ),
    );
  }

  /// 首页
  _homePage() {
    return Expanded(
      child: SizedBox(
        height: 69,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JellyButton(
              onTap: () {
                setState(
                  () {
                    _currenIndex = 0;
                  },
                );
              },
              checked: _currenIndex == 0 ? true : false,
              size: const Size(40, 40),
              unCheckedImgAsset: 'assets/images/tab/home.png',
              checkedImgAsset: 'assets/images/tab/home_select.png',
            ),
            Text(
              AppLocalizations.of(context).homeTitle!,
              style: TextStyle(
                color: _currenIndex == 0 ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 我的
  _minePage() {
    return Expanded(
      child: SizedBox(
        height: 69,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JellyButton(
                  onTap: () {
                    setState(
                      () {
                        _currenIndex = 1;
                      },
                    );
                  },
                  checked: _currenIndex == 1 ? true : false,
                  size: const Size(40, 40),
                  unCheckedImgAsset: 'assets/images/tab/mine.png',
                  checkedImgAsset: 'assets/images/tab/mine_select.png',
                ),
                Text(
                  AppLocalizations.of(context).mineTitle!,
                  style: TextStyle(
                    color: _currenIndex == 1 ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
            _angleStr == ''
                ? Container()
                : Positioned(
                    right: 72,
                    top: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      child: Center(
                        child: Text(
                          _angleStr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
