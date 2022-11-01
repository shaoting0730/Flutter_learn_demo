import 'package:flutter/material.dart';
import 'package:riverpod_pro/utils/export_library.dart';

class OtherPage extends ConsumerStatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  OtherPageState createState() => OtherPageState();
}

class OtherPageState extends ConsumerState<OtherPage> with SingleTickerProviderStateMixin {
  late ScrollController _scrollViewController;
  late TabController _tabController;

  int a = 0;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                //头部整个背景颜色
                height: double.infinity,
                color: Color(0xffcccccc),
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ),
            bottom: TabBar(controller: _tabController, tabs: [
              Tab(text: "aaa"),
              Tab(text: "bbb"),
              Tab(text: "ccc"),
            ]),
          )
        ];
      },
      body: TabBarView(controller: _tabController, children: [
        _buildListView("aaa:"),
        _buildListView("bbb:"),
        _buildListView("ccc:"),
      ]),
    );
  }

  Widget _buildListView(String s) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey,
        height: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(color: Colors.white, child: ListTile(title: Text("$s第$index 个条目")));
      },
    );
  }
}
