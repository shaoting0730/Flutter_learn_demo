>  打开模拟器  运行  1.cd 根目录  2.flutter run -d all 或者 flutter run  => ps:flutter packages get 获取三方库 <br/>
> 调试: r: 运行 R:重新运行 p:显示网格 大写P:显示性能 o:切换模拟器 s:保存截图  h:显示帮助信息 q:退出. 3.切换版本: flutter channels  && flutter channels XXX 之后 flutter upgrade即可 git checkout xxx . 打开dubug开启真热更新 You can dump the widget hierarchy of the app (debugDumpApp) by pressing "w". <br/>
> To dump the rendering tree of the app (debugDumpRenderTree), press "t". <br/>
> For layers (debugDumpLayerTree), use "L"; for accessibility  <br/>
> (debugDumpSemantics), use "S" (for traversal order) or "U" (for inverse hit test order).  <br/>
> To toggle the widget inspector (WidgetsApp.showWidgetInspectorOverride), press "i".  <br/>
> To toggle the display of construction lines (debugPaintSizeEnabled), press "p".  <br/>
> To simulate different operating systems, (defaultTargetPlatform), press "o".  <br/>
> To display the performance overlay (WidgetsApp.showPerformanceOverlay), press "P".  <br/>
> To save a screenshot to flutter.png, press "s".  <br/>
> To repeat this help message, press "h". To detach, press "d"; to quit, press "q".  <br/>
> vim ~/.bash_profile 
> source ~/.bash_profile


<!-- /lib/main.dart#L14-L21    -->


> [ 下载单个文件 ]( https://minhaskamal.github.io/DownGit/#/home )   <br/>

## 图书推荐
> [ 京东：Flutter组件详解与实战 王浩然·著 ⭐️⭐️⭐️⭐️⭐️ ]( https://item.jd.com/13623408.html )   <br/>
> [ 张风捷特烈 的掘金课程 ⭐️⭐️⭐️⭐️⭐️ ]( https://juejin.cn/user/149189281194766/course )   <br/>
> [ Flutter&Rust 应用开发 ⭐️⭐️⭐️⭐️⭐ ]( https://juejin.cn/column/7411457479572078643 )    <br/>

## 开发过程中,使用到的棒棒哒の开发库和爬坑历程
> [ 列表 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E9%81%87%E5%88%B0%E7%9A%84%E5%A5%BD%E5%BA%93.md )   <br/>
> [ 爬坑历程 ]( https://www.cnblogs.com/shaoting/p/10235652.html )   <br/>

## 基础widget
> [ button ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/button_demo )   <br/>
> [ text ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/text_demo )   <br/>
> [ textfield ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/textfield_demo  )   <br/>
> [ form ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/form_demo  )   <br/>
> [ image ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/image_demo  )   <br/>
> [ Flutter 图片加载流程 ]( https://juejin.cn/post/7029668872617721893 )   <br/>
> [ switch checkbox ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/switch_checkbox_demo )<br/>
> [ card ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/基础Widget/gradwidget_demo )<br/>
> [ positionwidget ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/positionwidget )<br/>
> [ stackwidget ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/stackwidget )<br/>
> [ push ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/push_demo )<br/>
> [ push传参 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/push_param_demo )<br/>
> [ ExpansionTile ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/expansion_tile )<br/>
> [ custompaint ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/custompaint_demo )<br/>
> [ ExpansionPaneList ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/expansionpanelist )<br/>
> [ PhysicalModel ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/physical_model_demo ) <br/>
> [ Overlay和Flow ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/overlay_flow )<br/>
> [ 虚线 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/dotted_line_demo )<br/>
> [ Offstage和Visibility和Opacity ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/OOV%E4%B8%89%E7%BB%84%E4%BB%B6 )<br/>
> [ 禁用与置灰 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/ignore_grey )<br/>
> [ IntrinsicHeight 和 IntrinsicWidth ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/intrinsic_height_demo )<br/>
> [ OOV三组件 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/OOV%E4%B8%89%E7%BB%84%E4%BB%B6 )<br/>
>  [ 切圆形图片的5个方法 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/border_radius_demo ) <br/>
>  [ Dart：var、final、const、late ]( https://blog.csdn.net/smileKH/article/details/129166883 ) <br/>
>  [late、dynamic、var ](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/late%26dynamic%26var.jpg)    <br/>
>  [ 使用自定义字体 安卓去除状态栏灰层 渐变色导航栏 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/custom_font_demo )    <br/>
> [ Chip FilterChip ChioceChip ActionChip  Divider  DataTable
PaginatedDataTable Stepper ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/mdc_demo )<br/>
> [ 添加引导页面 appBar DatePicker BottomSheet Dialog Stepper 滚动监听 雨滴动画 密码输入框 faceID&TouchID 与webView交互 上拉抽屉 回调 event_bus传值 WillPopScope监听Android物理返回键]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/widgets_demo )<br/>


## 布局widget  
> [ rowwidget ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/rowwidget_demo )<br/>
> [ columnwidget ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/columnwidget_demo )<br/>
> [ flex expanded ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/flex_expanded_demo )<br/>
> [ wrap_flow ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/wrap_flow )<br/>

## 容器widget
> [ Padding ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/padding_demo )<br/>
> [ constrainedbox sizedbox UnconstrainedBox ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/constrainedbox_sizedbox_demo )<br/>
> [ 全网最详细的一篇Flutter 尺寸限制类容器总结：老孟 ]( https://segmentfault.com/a/1190000021926139?utm_source=tag-newest )<br/>
> [ decoratedbox ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/decoratedbox_demo )<br/>
> [ transform ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/transform_demo )<br/>
> [ container ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/container )<br/>
## 滚动widget
> [ listview1 竖向 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo )  <br/>
> [ ListView源码分析之Viewport的作用 ]( https://juejin.cn/post/6891077340521037838 )  <br/>
> [ ListView重用机制 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E9%87%8D%E7%94%A8%E6%9C%BA%E5%88%B6.md )  <br/>
> [ listview2 横向]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo2 )<br/>
> [ listview3 动态数据]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo3 )<br/>
> [ 嵌套listview ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/more_list )<br/>
> [ gridview ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/gridview_demo )<br/>
> [ customscrollview ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/customscrollview_demo )<br/>
> [ NestedScrollView ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/nested_scroll_view_demo )<br/>
> [ scroll ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scroll_widget ) [ 👉🏻解析 ]( https://www.jianshu.com/p/41764e5b3b58 ) <br/>
> [ scroll 滚动控制1 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scrollcontroller_demo )<br/>
> [ scroll 滚动控制2 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scrollcontroller_demo1 )<br/>

## 功能Widget
>   [ Android双击物理键退出app 主体Theme学习 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/functional_module/lib/main.dart )    <br/>
> [ 模糊效果:filter_widget ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/filter_widget )<br/>
> [ 轻提示 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/tool_tips )<br/>
> [ 弹出框 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/alert_demo )<br/>
> [ ShaderMask ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/shader_mask_demo )   <br/>
> [ 打破约束组件 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/%E6%89%93%E7%A0%B4%E7%BA%A6%E6%9D%9F )   <br/>
> [ 保持状态 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/keep_alive_demo )<br/>
> [ LayoutBuilder && OrientationBuilder ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/layoutbuild_demo )<br/>
> [ 通知Notification ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/notification_demo )<br/>
> [ RxDart初识 ](  https://github.com/shaoting0730/Flutter_learn_demo/blob/master/RxDart%E5%88%9D%E5%A7%8B.md )<br/>
> [ Stream RxDart学习 ](  https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/stream_demo )<br/>

## 混合开发
 > [ Flutter-PlatformView简单尝试 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/platformview )<br/>
 > [ iOS原生中集成Flutter模块 ]( https://zhoushaoting.com/2019/05/29/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~iOS%E5%8E%9F%E7%94%9F%E5%B7%A5%E7%A8%8B%E4%B8%AD%E6%B7%BB%E5%8A%A0Flutter%E6%A8%A1%E5%9D%97/ )<br/>
 > [ Android原生中集成Flutter模块 ]( https://zhoushaoting.com/2019/05/31/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~Android%E5%8E%9F%E7%94%9F%E5%B7%A5%E7%A8%8B%E4%B8%AD%E6%B7%BB%E5%8A%A0Flutter%E6%A8%A1%E5%9D%97/ )<br/>
 > [ flutter_boost学习视频 ](  https://www.bilibili.com/video/av68165113?from=search&seid=6069933847949675176 )<br/>
 > [ flutter_boost教程 ]( https://www.jianshu.com/p/679a642ade52 )<br/>
 > [ flutter_boost源码浅析 ]( https://juejin.im/post/5e61b803f265da57127e526c )<br/>
 > [ 深入理解Flutter Platform Channel ]( https://zhuanlan.zhihu.com/p/43226013 )<br/>
 > [ Flutter开发必须掌握的Channel通道以及不同的定义方式 ]( https://juejin.cn/post/7278684023757176895?utm_source=gold_browser_extension )<br/>
 > [ Flutter新锐专家之路：混合开发篇 ]( https://developer.aliyun.com/article/626069 )<br/>
 > [ 官方Demo ]( https://github.com/flutter/samples/blob/master_archived/platform_channels/README.md )<br/>
 > [ Flutter 混合架构方案探索 ]( https://juejin.cn/post/7262616799219482681 )<br/>



## 热更新方案
 > [ Flutter暂时放弃热更新的官方解释 ](  https://github.com/flutter/flutter/issues/14330#issuecomment-485565194 )<br/>
 > [ 混栈开发之Android端Flutter热更新 ](  https://github.com/magicbaby810/HotfixFlutter )<br/>
 > [ chimera_flutter_code_push ](  https://github.com/ChimeraFlutter/Chimera-Flutter-Code-Push )<br/>
 > [ fair ](  https://github.com/wuba/fair/blob/main/README-zh.md )<br/>
 > [ 美团外卖Flutter动态化实践：但分析美团的APP，他们使用的仍然是RN的热更新 ](  https://mp.weixin.qq.com/s/wjEvtvexYytzSy5RwqGQyw )<br/>
 > [ 热更新？ ](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B3%E4%BA%8E%E7%83%AD%E6%9B%B4%E6%96%B0.md) <br/>
 

## 性能优化
 > [ 生命周期 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F.md )<br/>
 > [ 性能优化 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96 )<br/>
 

## 源码解读
 > [ 常用组件源码分析-继承关系相关 ]( https://zhoushaoting.com/2022/09/01/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%B8%B8%E7%94%A8%E7%BB%84%E4%BB%B6%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%901/ )<br/> 
 
 
## 渲染引擎 [ skia ]( https://github.com/google/skia ) [ impeller ]( https://github.com/flutter/engine/tree/main/impeller )   <br/>
> [ flutter新引擎impller与skia的区别 ]( https://juejin.cn/post/7217743118328692794 )   <br/>
> [ 引擎初始化、启动流程都做了啥？2w 字源码解析 ]( https://juejin.cn/post/7010655914025811975 )   <br/>
> [ 深入理解Flutter的图形图像绘制原理——图形库skia剖析 ]( https://juejin.cn/post/6914188284126035981 )   <br/>
> [ 深入解析Flutter下一代渲染引擎Impeller ]( https://blog.csdn.net/YZcoder/article/details/126501428 )   <br/>
> [ Flutter 新一代图形渲染器 Impeller ]( https://mp.weixin.qq.com/s/PLvlSt3tlX6AjufDm0XVMA )   <br/>
> [ 着色器预热 ]( https://juejin.cn/post/7385942645232828442?utm_source=gold_browser_extension )   <br/>


## 杂类
> [ dart model 方案 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/JSON2DARTMODEL.md  )<br/>
> [ var、final、const、late的各自场景 ](  https://blog.csdn.net/smileKH/article/details/129166883 )<br/>
> 个人认为： Dart基本数据类型是值传递，对象类型是指针传递 对于此， [ 大家众说纷纭 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%80%BC%E4%BC%A0%E9%80%92%E8%BF%98%E6%98%AF%E5%BC%95%E7%94%A8%E4%BC%A0%E9%80%92.md  )   <br/>
> [ 深入理解 Dart 空安全 ]( https://mp.weixin.qq.com/s?__biz=MzUyMjg5NTI3NQ%3D%3D&chksm=f9c5a3e0ceb22af6df941085ca63a0ef47cde933c0941a1476ba02db32bd1dcc61da550b11a3&idx=1&mid=2247485732&scene=21&sn=29d97abefd947748ee9df2c1f035cd4f#wechat_redirect ) <br/>
>  [通知 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E4%BA%8B%E4%BB%B6%E4%B8%8E%E9%80%9A%E7%9F%A5/notification/lib/main.dart )    <br/>
>  [ 事件 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E4%BA%8B%E4%BB%B6%E4%B8%8E%E9%80%9A%E7%9F%A5/pointer/lib/main.dart )    <br/>
>  [ 手势 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%89%8B%E5%8A%BF/destruedetector/lib/main.dart )    <br/>
>  [ 约束 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E7%BA%A6%E6%9D%9F.md )    <br/>
>  [ 组合Widget 示例1 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/%E7%BB%84%E5%90%88Widget/composite_widget )    <br/>
>  [ 组合Widget 示例2 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/%E7%BB%84%E5%90%88Widget/turnbox )    <br/> 
>  [ Overlay 实现 Flutter 实现全局气泡 ]( https://juejin.cn/post/7299353745498980362 )    <br/> 
>  [ custompaint_canvas ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/CustomPaint%E4%B8%8ECanvas/custompaint_canvas )    <br/> 
>  [ progressbar ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/CustomPaint%E4%B8%8ECanvas/progressbar )    <br/> 
>  [ 文件操作 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E8%AF%BB%E5%86%99%E8%AF%B7%E6%B1%82/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C/file_operations/lib/main.dart )    <br/>
>  [ HttpClient ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/HttpClient/httpclient_demo/lib/main.dart )    <br/>
>  [ dio库 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/DioPackage/dio_package_demo/lib/main.dart )    <br/>
>  [ SQLite:sqflite库简单学习 ](https://zhoushaoting.com/2019/03/04/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter%E4%B8%AD%E7%9A%84sqflite%E5%BA%93%E5%AD%A6%E4%B9%A0/ )    <br/>
>  [ json转实体类:json_serializable库学习 ]( https://zhoushaoting.com/2019/03/06/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~json_serializable%E5%BA%93%E5%AD%A6%E4%B9%A0/ )    <br/>
> [ tabBar ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo )<br/>
> [ tabBar1 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo1 )<br/>
> [ tabBar2 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo2 )<br/>
> [ tabBar3:类今日头条上方tabbar ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/top_tabbars_demo )<br/>
> [ 路由管理库fluro学习 ]( https://zhoushaoting.com/2019/03/30/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86%E5%BA%93fluro%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ 路由过渡动画 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/push%E5%8A%A8%E7%94%BB/push_animation_demo )<br/>
> [ InheritedWidget和ChangeNotifier相关 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/InheritedWidget%E7%9B%B8%E5%85%B3.md )<br/>
> [ Flutter 知识进阶 - 异步编程：张风捷特烈 ]( https://juejin.cn/column/7141354641874223112 )<br/>
> [ Stream相关 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/Stream%E7%9B%B8%E5%85%B3.md )<br/>
> [ Stream和Future ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/Future%E5%92%8CStream.md )<br/>
> [ Flutter启动系列之Dart虚拟机启动 ]( https://xiaozhuanlan.com/topic/7039642518 )<br/>
> [ Future相关 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/Future%E7%9B%B8%E5%85%B3.md )<br/>
> [ Flutter Engine线程管理与Dart Isolate机制 ]( https://blog.csdn.net/alitech2017/article/details/81108487 )<br/>
> [ 聊一聊Flutter线程管理与Dart Isolate机制 ]( https://zhuanlan.zhihu.com/p/40069285 )<br/>
> [ Flutter 事件循环 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E4%BA%8B%E4%BB%B6%E5%BE%AA%E7%8E%AF.md )<br/>
> [ Flutter异步编程之 Future/Isolate ]( https://www.jianshu.com/p/252fb36ed13d )<br/>
> [ Key ]( https://juejin.cn/post/7050003302041255973 )<br/>
> [ Flutter Keys：你的终极指南，让 widget 世界更快乐 ]( https://mp.weixin.qq.com/s/fymCUTyO-yMA2L-b67rjtg )<br/>
> [ Key:demo ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/key )<br/>
> [ Dart 健全的空安全 ]( https://mp.weixin.qq.com/s/zdlsdv8ymyQTHmf1iLCyWA )    <br/>
> [ Flutter原理简解 ]( https://www.stephenw.cc/2018/05/14/flutter-principle/ )<br/>
> [ Flutter启动系列之Dart虚拟机启动 ]( https://xiaozhuanlan.com/topic/7039642518 )<br/>
 > [ AST树分析？ ](https://toutiao.io/posts/p77w8kw/preview) <br/>
> [ 重写运算符 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E9%87%8D%E5%86%99%E8%BF%90%E7%AE%97%E7%AC%A6.md )<br/>
> [ Flutter编译模式 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E7%BC%96%E8%AF%91%E6%A8%A1%E5%BC%8F.md )<br/>
> [ Widget、Element、RenderObject三者之间的关系 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E4%B8%89%E6%A3%B5%E6%A0%91.md )<br/>
> [ 理解BuildContext ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/BuildContext.md )<br/>
> [ Flutter启动流程分析 ](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/Flutter%E5%90%AF%E5%8A%A8%E6%B5%81%E7%A8%8B%E5%88%86%E6%9E%90.md)<br/>
> [ setState原理分析 ](  https://github.com/shaoting0730/Flutter_learn_demo/blob/master/flutter-setState%E5%8E%9F%E7%90%86%E5%88%86%E6%9E%90.md )<br/>
> [ RenderSliver 和 RenderBox 的异同 ](  https://github.com/shaoting0730/Flutter_learn_demo/blob/master/RenderSliver%E5%92%8CRenderBox%E5%BC%82%E5%90%8C.md )<br/>
> [ Dart中继承、混入、实现、抽象类 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E6%B7%B7%E5%85%A5%E3%80%81%E7%BB%A7%E6%89%BF%E3%80%81%E5%AE%9E%E7%8E%B0.md )<br/>
> [ 内存相关 ](  https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%86%85%E5%AD%98%E7%9B%B8%E5%85%B3.md )<br/>
> [ DartVM相关 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/DartVM%E7%9B%B8%E5%85%B3.md )<br/>
> [ restorationId 的使用 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/restoration_id_demo/lib/main.dart )<br/>
> [ 使用flutter开发鸿蒙？ ]( https://gitee.com/openharmony-sig/flutter_flutter )<br/>


## state管理
> [ Flutter State Management状态管理全面分析 ]( https://www.jianshu.com/p/9334b8f68004 ) <br/>
> [ Flutter 状态管理：源码探索与实战 ]( https://juejin.cn/book/7292478072568643584/section/7292474787618619432?utm_source=profile_book ) <br/> 
> [ Flutter Riverpod 全面深入解析，为什么官方推荐它？ ]( https://juejin.cn/post/7063111063427874847 ) <br/> 
> [ riverpod学习 ]( https://zhoushaoting.com/2022/08/01/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~riverpod%E5%BA%93%E5%AD%A6%E4%B9%A0/ ) <br/> 
> [ Flutter官方团队对getx这个插件的态度和看法？？？ ]( https://github.com/flutter/website/pull/4981 ) <br/> 
> [ getx学习 ]( https://zhoushaoting.com/2021/03/13/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~getx%E5%AD%A6%E4%B9%A0/ ) <br/> 
> [ getx学习 ]( https://segmentfault.com/a/1190000039139198 ) <br/> 
> [ scoped_model学习 ]( https://zhoushaoting.com/2019/02/16/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~scoped_model%E5%AD%A6%E4%B9%A0/ ) <br/> 
> [ redux学习 ]( https://zhoushaoting.com/2019/02/17/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~redux%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ provide学习 ]( https://zhoushaoting.com/2019/03/03/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~provide%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ provider学习 ]( https://zhoushaoting.com/2021/01/06/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~provider%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ mobx学习 ](https://zhoushaoting.com/2019/08/08/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~mobx%E5%BA%93%E5%AD%A6%E4%B9%A0/) <br/>
> [ bloc模式学习 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/bloc_tips ) <br/>
> [ flutter_bloc学习 ]( https://zhoushaoting.com/2019/03/07/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~flutter_bloc%E5%BA%93%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ fish redux pdf ](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/Flutter%E5%BA%94%E7%94%A8%E6%A1%86%E6%9E%B6Fish%20Redux.pdf)  <br/>
> [ 阿里fish redux视频 ](https://alivideolive.taobao.com/h5/liveDetail/ff36146a-b106-48f0-8cff-246fa0b62d50) <br/>
> [ 阿里fish redux初识 ](https://www.yuque.com/xytech/flutter/ycc9ni) <br/>
> [ 阿里fish redux中文介绍 ](https://hzgotb.github.io/fish-redux-docs/zh/guide/get-started/) <br/>
> [ fish_redux模版工具FishReduxTemplateForAS-Android Studio ](https://github.com/BakerJQ/FishReduxTemplateForAS) <br/>
> [ fish_redux模版工具fish-redux-template-VScode](https://marketplace.visualstudio.com/items?itemName=huangjianke.fish-redux-template) <br/>
> [ fish_redux Demo(含Tabbar、model、dio、基本传值、component、globalStore、adapter) ]( https://zhoushaoting.com/2020/04/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~fish_redux%E5%AD%A6%E4%B9%A0/) <br/>
> [ fish_redux Demo1(无Tabbar最简单版本) ](
https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/fish_redux_demo1) <br/>


### 案例
> [ 基本项目架子，基于getx、flutter2.5.0 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/init_demo) <br/>
> [ 基本项目架子，基于getx、flutter2.10.4 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/init_demo1) <br/>
> [ 基本项目架子，基于riverpod、flutter3.3.4 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/riverpod_pro) <br/>
> [ 案例0 对Widget和BoxDecoration 进行扩展 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/%E4%B8%80%E4%BA%9B%E5%B0%8F%E7%8E%A9%E6%84%8F/extensions) 和 [一些对现有组件的封装使用](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/%E4%B8%80%E4%BA%9B%E5%B0%8F%E7%8E%A9%E6%84%8F/widget)<br/>
> [ 案例1 选项卡 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case1) <br/>
> [ 案例2 输入联想](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case2) <br/>
> [ 案例3 图片增加](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case3) <br/>
> [ 案例4 贝塞尔曲线 ](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case4) <br/>
> [ 案例5 启动屏 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case5) <br/>
> [ 案例6 类[SOUL]app一样的3D球 ](https://github.com/shaoting0730/3DBall) <br/>
> [ 案例7 Draggable学习](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case7) <br/>
> [ 案例8 侧滑框](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case8) <br/>
> [ 案例9 Slivers全家桶学习](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case9) <br/>
> [ 案例10 导航条渐隐](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/opacity_nav) <br/>
> [ 案例11 CanVas学习:签名板]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/canvas_demo ) <br/>
> [ 案例12 国际化方案]( https://zhoushaoting.com/2019/06/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%9B%BD%E9%99%85%E5%8C%96%E6%95%99%E7%A8%8B%E6%96%B9%E6%A1%88/ ) <br/>
> [ 案例13 动画](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/animation_demo) <br/>
> [ 案例14 自定义push动画]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/push%E5%8A%A8%E7%94%BB/push_animation_demo ) <br/>
> [ 案例15 Flare学习](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/其他/案例/flare_learn) <br/>
> [ 案例16 自定义Dialog和基本的组件封装](https://zhoushaoting.com/2019/11/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E8%87%AA%E5%AE%9A%E4%B9%89Dialog(%E5%9F%BA%E6%9C%AC%E7%9A%84%E7%BB%84%E4%BB%B6%E5%B0%81%E8%A3%85)/) <br/>
> [ 案例17 UI根据角色判断(fish——redux数据流store分开,UI分开,逻辑分开) ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/diffrent_user_tab )<br/>
> [ 案例18 自定义相机页面](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/camera_demo) <br/>
> [ 案例19 自定义下拉框](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/drop_down_box_demo) <br/>
> [ 案例20 性能优化点](https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96.md ) <br/>
> [ 案例21 全局倒计时 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/verification_code_page ) <br/>
> [ 案例22 键盘相关：监听键盘弹出\缩回事件，点击空白缩回键盘、点击按钮弹出键盘](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/keyboard_tips) <br/>
> [ 案例23 广告页面 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/ad_page) <br/>
> [ 案例24 保存图片新版本 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/android_ios_saveimage
) <br/>
> [ 案例25 自定义tarbar ](https://zhoushaoting.com/2020/01/23/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E8%87%AA%E5%AE%9A%E4%B9%89tabbar%E6%A8%A1%E5%9D%97/) <br/>
> [ 案例26 PreferredSize 实现自定义tabbar](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/PreferredSize_demo) <br/>
> [ 案例27 Listview 第一次加载时动画 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/listview_item_demo )  <br/>
> [ 案例28 Lottie动画 SVGAPlayer动画 手柄控制 滑动解锁 AnimatedSwitcher示例 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/animation_go )  <br/>
> [ 案例29 跳转三方库导航 ]( https://github.com/shaoting0730/Flutter_learn_demo/blob/master/%E8%B7%B3%E8%BD%AC%E4%B8%89%E6%96%B9%E5%BA%93%E5%BC%80%E5%A7%8B%E5%AF%BC%E8%88%AA.md )  <br/> 
> [ 案例30 游戏手柄 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/game_contro) <br/>
> [ 案例31 自绘键盘1 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/custom_keyboard/#mark1) <br/>
> [ 案例32 自绘键盘2 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/custom_keyboard/#mark2) <br/>
> [ 案例34 web放大镜 ](https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/magnifier_demo) <br/>
> [ 案例35 退至后台锁定界面 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/app_lifecycle ) <br/>
> [ 案例36 customSingleChildLayout 示例 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/custom_single_child_layout_demo ) <br/>
> [ 案例37 自定义一个controller ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/custom_controller ) <br/>
> [ 案例38 自定义一个provider相关 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/state_example ) <br/>
> [ 案例39 自定义一个ListVist： Scrollable 和 Viewport组件的作用 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/custom_listview ) <br/>
> [ 案例40 省市区联动picker ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/city_picker ) <br/>
> [ 案例41 图片下拉放大 ]( https://github.com/shaoting0730/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/enlarge_img ) <br/>
