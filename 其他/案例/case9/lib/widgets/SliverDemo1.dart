import 'package:flutter/material.dart';

class SliverDemo1 extends StatefulWidget {
  @override
  State<SliverDemo1> createState() => _SliverDemo1State();
}

class _SliverDemo1State extends State<SliverDemo1> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            elevation: 0,
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: 150,
            title: Text('我是标题'),
            onStretchTrigger: () async {
              return;
            },
            stretch: true, //是否可拉伸伸展
            stretchTriggerOffset: 150, //触发拉伸偏移量
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/timg.jpg',
                fit: BoxFit.cover,
              ),
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "This is item $i",
                  ),
                  color: Colors.white70,
                );
              },
              childCount: 280,
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 900,
          //     color: Colors.red,
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 900,
          //     color: Colors.red,
          //   ),
          // ),
        ],
      ),
    );
  }
}
