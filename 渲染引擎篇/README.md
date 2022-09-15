## skia
其中，iOS UI采用CoreAnimation库，底层是OpenGL和Metal。 <br/>
Android UI和Flutter UI采用skia库，底层是Vulkan OpenGL Metal。<br/>
OpenGL是使用最广的低级图形接口，兼容性最好，基本上支持市面上的所有GPU。Vulkan是最近几年新推出的图形API，除了iPhone的GPU，其他厂家的GPU基本都支持。Metal是苹果新推出的图形API，只支持自家GPU。<br/>
GPU渲染的并行运算能力强，目前大部分移动设备都采用的是GPU渲染。<br/>
字体无法直接显示在屏幕上，需要解析成位图或者矢量图才能绘制。Skia的字体解析实现跟进平台差异有所不同，mac和iOS平台调用coreText库,安卓平台调用开源库freeType。<br/>

## Impeller
Impeller 的出现是 Flutter 团队用以彻底解决 SkSL（Skia Shading Language） 引入的 Jank 问题所做的重要尝试（部分场景下会出现卡顿现象）。

> [ 深入理解Flutter的图形图像绘制原理——图形库skia剖析 ]( https://juejin.cn/post/6914188284126035981 )   <br/>
> [ 深入解析Flutter下一代渲染引擎Impeller ]( https://blog.csdn.net/YZcoder/article/details/126501428 )   <br/>

