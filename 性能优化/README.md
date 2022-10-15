1、项目中，可以只使用2X、3X的图，不使用1X的图。因为市面上，1X图的手机应该很少有了。或者干脆采用SVG图片。 <br/>
市面上还在使用1X的设备： <br/>
所有non-Retina mac电脑 |  苹果iPhone3g |  苹果iPhone3gs | 苹果iPad(第一代) | 苹果iPad2|  苹果iPad迷你（第一代）|  鸿基Iconia A500 |  三星Galaxy Tab 10.1 |  三星Galaxy S  <br/>
2、对于一个UI之上，需要state的Widget,应该单独提取出来，避免造成过多的UI再次render。<br/>
3、因为根界面是常驻内存的，所以在此界面之上，因为竟可能减少一些消耗占用内存的现象，如监听。<br/>
4、在使用了controller、动画、定时器、监听器的页面，当页面销毁时，一定会移除相应的事情，避免内存泄露，如 XXXX.cancel()。<br/>
5、在使用CustomPainter绘制复杂UI的时候，可以在其外部包裹一个RepaintBoundary，避免同级的UI发生改变，造成CustomPainter重绘。如 [ RepaintBoundary示例 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/RepaintBoundary_demo )   <br/>
6、[ 如何缩减接近 50% 的 Flutter 包体积 ]( https://mp.weixin.qq.com/s/Ls3cDcqjlyOX80PXUO0wRw  )    <br/>
7、当使用`ListView`等列表组件时，尽量使用`builder`的UI构建方式，这样才能采用重用机制，而不是一下子把所有子UI都加载进来；同时如果可以确定单个`item`的宽高的话，可以使用`cacheExtent`属性来固定宽高，这样也可以大幅度提高性能。

