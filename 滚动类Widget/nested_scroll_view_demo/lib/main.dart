import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sliver_header/sliver_pinned_header.dart';
import 'sliver_header/sliver_snap_header.dart';
import 'views/search_bar.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = <String>['关注', '推荐', '热榜', '精选'];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      const SliverSnapHeader(
        child: SearchBar(),
      ),
      SliverOverlapAbsorber(
        sliver: SliverPinnedHeader(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          ),
        ),
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child:
            NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: _buildHeader,
              body: TabBarView(
                controller: tabController,
                children: _tabs.map(buildScrollPage).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScrollPage(String name) {
    return Builder(
      builder: (BuildContext context) => CustomScrollView(
        key: PageStorageKey<String>(name),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverFixedExtentList(
              itemExtent: 48.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
