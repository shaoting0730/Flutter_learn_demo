import 'package:flutter/material.dart';
import '../widgets/up_drawer_widget.dart/bottom_drag_widget.dart';

class UpDrawerDemo extends StatefulWidget {
  UpDrawerDemo({Key key}) : super(key: key);

  _UpDrawerDemoState createState() => _UpDrawerDemoState();
}

class _UpDrawerDemoState extends State<UpDrawerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('上拉抽屉')),
      body: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return BottomDragWidget(
        body: Container(
          color: Colors.red[300],
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Text('我是主体内容$index');
            },
            itemCount: 100,
          ),
        ),
        dragContainer: DragContainer(
          drawer: getListView(),
          defaultShowHeight: 150.0,
          height: MediaQuery.of(context).size.height - 200,
        ));
  }

  Widget getListView() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,

      ///总高度
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            height: 40.0,
            child: Text('我是头部'),
          ),
          Expanded(child: newListView())
        ],
      ),
    );
  }

  Widget newListView() {
    return OverscrollNotificationWidget(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text('我是抽屉内容=$index');
        },
        itemCount: 100,

        ///这个属性是用来断定滚动的部件的物理特性，例如：
        ///scrollStart
        ///ScrollUpdate
        ///Overscroll
        ///ScrollEnd
        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置

        ///下面代码是我在翻源码找到的解决方案
        /// The scroll physics to use for the platform given by [getPlatform].
        ///
        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
        /// Android.
//  ScrollPhysics getScrollPhysics(BuildContext context) {
//    switch (getPlatform(context)) {
//    case TargetPlatform.iOS:/*/
//         return const BouncingScrollPhysics();
//    case TargetPlatform.android:
//    case TargetPlatform.fuchsia:
//        return const ClampingScrollPhysics();
//    }
//    return null;
//  }
        ///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
        ///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
        ///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
        ///故这里，设定为[ClampingScrollPhysics]
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}
