1、项目中，可以只使用2X、3X的图，不使用1X的图。因为市面上，1X图的手机应该很少有了。或者干脆采用SVG图片。 <br/>
市面上还在使用1X的设备： <br/>
所有non-Retina mac电脑 |  苹果iPhone3g |  苹果iPhone3gs | 苹果iPad(第一代) | 苹果iPad2|  苹果iPad迷你（第一代）|  鸿基Iconia A500 |  三星Galaxy Tab 10.1 |  三星Galaxy S  <br/>
2、对于一个UI之上，需要state的Widget,应该单独提取出来，避免造成过多的UI再次render。<br/>
3、因为根界面是常驻内存的，所以在此界面之上，因为竟可能减少一些消耗占用内存的现象，如监听。<br/>
4、在使用了controller、动画、定时器、监听器的页面，当页面销毁时，一定会移除相应的事情，避免内存泄露，如 XXXX.cancel()。<br/>
5、在使用CustomPainter绘制复杂UI的时候，可以在其外部包裹一个RepaintBoundary，避免同级的UI发生改变，造成CustomPainter重绘。如 [ RepaintBoundary示例 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/RepaintBoundary_demo )   <br/>
6、[ 如何缩减接近 50% 的 Flutter 包体积 ]( https://mp.weixin.qq.com/s/Ls3cDcqjlyOX80PXUO0wRw  )    <br/>
7、当使用`ListView`等列表组件时，尽量使用`builder`的UI构建方式，这样才能采用重用机制，而不是一下子把所有子UI都加载进来；同时如果可以确定单个`item`的宽高的话，可以使用`cacheExtent`属性来固定宽高，这样也可以大幅度提高性能。
8、如果开发中，需要返回一个空的widget，我们可以返回一个Container()或者SizedBox(),但是这样还是会渲染出来，可以采用 [ nil库 ]( https://github.com/letsar/nil  )，其源码大致
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
