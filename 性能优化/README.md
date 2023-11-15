1、项目中，可以只使用2X、3X的图，不使用1X的图。因为市面上，1X图的手机应该很少有了。或者干脆采用SVG图片。 <br/>
市面上还在使用1X的设备： <br/>
所有non-Retina mac电脑 |  苹果iPhone3g |  苹果iPhone3gs | 苹果iPad(第一代) | 苹果iPad2|  苹果iPad迷你（第一代）|  鸿基Iconia A500 |  三星Galaxy Tab 10.1 |  三星Galaxy S  <br/>
2、对于一个UI之上，需要state的Widget,应该单独提取出来，避免造成过多的UI再次render。或者考虑使用[ ValueListenableBuilder ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/value_widget_builder_demo  ) <br/>
3、因为根界面是常驻内存的，所以在此界面之上，因为竟可能减少一些消耗占用内存的现象，如监听。<br/>
4、在使用了controller、动画、定时器、监听器的页面，当页面销毁时，一定会移除相应的事情，避免内存泄露，如 XXXX.cancel()。<br/>
5、在使用CustomPainter绘制复杂UI的时候，可以在其外部包裹一个RepaintBoundary，避免同级的UI发生改变，造成CustomPainter重绘。如 [ RepaintBoundary示例 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/RepaintBoundary_demo )   <br/>
6、[ 如何缩减接近 50% 的 Flutter 包体积：李梦云 字节跳动技术团队 2019-12-05 09:44 ]( https://mp.weixin.qq.com/s/Ls3cDcqjlyOX80PXUO0wRw  )  <br/>
      [ Flutter瘦身大作战  闲鱼技术-三莅 2019-12-05 09:44 ]( https://www.yuque.com/xytech/flutter/hnxs1g    )  <br/>
7、当使用`ListView`等列表组件时，尽量使用`builder`的UI构建方式，这样才能采用重用机制，而不是一下子把所有子UI都加载进来；同时如果可以确定单个`item`的宽高的话，可以使用`cacheExtent`属性来固定宽高，这样也可以大幅度提高性能。 <br/>
8、如果开发中，需要返回一个空的widget，我们可以返回一个Container()或者SizedBox(),但是这样还是会渲染出来，可以采用 [ nil库 ]( https://github.com/letsar/nil  )，其源码大致

<details>

```

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

/// A [Nil] instance, you can use in your layouts.
const nil = Nil();

/// A widget which is not in the layout and does nothing.
/// It is useful when you have to return a widget and can't return null.
class Nil extends Widget {
  /// Creates a [Nil] widget.
  const Nil({Key? key}) : super(key: key);

  @override
  Element createElement() => _NilElement(this);
}

class _NilElement extends Element {
  _NilElement(Nil widget) : super(widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    assert(parent is! MultiChildRenderObjectElement, """
        You are using Nil under a MultiChildRenderObjectElement.
        This suggests a possibility that the Nil is not needed or is being used improperly.
        Make sure it can't be replaced with an inline conditional or
        omission of the target widget from a list.
        """);

    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {}
}
```
这样既可以返回widget，又不会实际渲染出来了。

</details>

9、避免将一些耗时计算放在UI线程，我们可以把耗时计算放到Isolate去执行，使用compute

<details>
  
```

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> getData() {
    // https://www.youtube.com/watch?v=5AxWC49ZMzs&ab_channel=Flutter
    var data = compute(doSomeThing, '11111');
    return data;
  }

  static dynamic doSomeThing(String str) {
    // 耗时操作
    print(str); // 11111
    int result = int.parse(str) * 2;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Container(
            child: Text('${snapshot.data}'),
          );
        },
      ),
    );
  }
}

```

</details>
10、其实开发中，只要只要注意好`Flutter 高性能的关键就是 Element 的更新复用机制`就没有啥性能担忧。<br/>
开始入口 <br/>
<details>

```

import 'package:ceshi/one.dart';
import 'package:ceshi/two.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Two(), // One()
    );
  }
}

```

</details>
One这种 ❎<br/>
<details>

```
import 'package:flutter/material.dart';

class One extends StatefulWidget {
  const One({Key? key}) : super(key: key);

  @override
  State<One> createState() => _OneState();
}

class _OneState extends State<One> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _incrementCounter,
              child: Text('点击我 $_counter'),
            ),
            Container(
              height: 200,
            ),
            ChildWidget(),
          ],
        ),
      ),
    );
  }
}

/// 1、输出会走
// class ChildWidget extends StatefulWidget {
//   const ChildWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ChildWidget> createState() => _ChildWidgetState();
// }
//
// class _ChildWidgetState extends State<ChildWidget> {
//   @override
//   Widget build(BuildContext context) {
//     print('走了吗？？？');
//     return Text('........');
//   }
// }

/// 2、输出也会走
class ChildWidget extends StatelessWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('走了吗？？？');
    return Text('。。。。。。');
  }
}

/// 优化方案： 可以把state 的_counter和点击组件Inkwell都拆出去，那么这个state的更改就只会更新他本身而已。
```

</details>
Two这种 ✅  <br/>
<details>

```

import 'package:flutter/material.dart';

class Two extends StatefulWidget {
  const Two({Key? key}) : super(key: key);

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddWidget(
              twoCallBack: (int count) {
                // print(count);
              },
            ),
            Container(
              height: 200,
            ),
            ChildWidget(),
          ],
        ),
      ),
    );
    ;
  }
}

/// 1、只在第一次初始化会走一次，之后不会走
class ChildWidget extends StatefulWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  Widget build(BuildContext context) {
    print('走了吗？？？');
    return Text('-------');
  }
}

/// 1、只在第一次初始化会走一次，之后不会走
// class ChildWidget extends StatelessWidget {
//   const ChildWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print('走了吗？？？');
//     return Text('-------');
//   }
// }

/// 单独把state拆出来
class AddWidget extends StatefulWidget {
  final twoCallBack;
  const AddWidget({Key? key, required this.twoCallBack}) : super(key: key);

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.twoCallBack(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _incrementCounter,
      child: Text('点击我 $_counter'),
    );
  }
}
```

</details>

10、[ Flutter 小技巧之 MediaQuery 和 build 优化你不知道的秘密 ]( https://juejin.cn/post/7114098725600903175?searchId=20231103175904D4AC41C8C00863D4AA3C )
