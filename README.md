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

### 下载单个项目,复制单个项目url到下面网址即可.
> [ DownGit ]( https://minhaskamal.github.io/DownGit/#/home )   <br/>

## 开发过程中,使用到的棒棒哒の开发库
> [ 列表 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E9%81%87%E5%88%B0%E7%9A%84%E5%A5%BD%E5%BA%93.md )   <br/>

## 基础widget
> [ button ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/button_demo )   <br/>
> [ text ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/text_demo )   <br/>
> [ textfield ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/textfield_demo  )   <br/>
> [ form ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/form_demo  )   <br/>
> [ image ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/image_demo  )   <br/>
> [ switch checkbox ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/switch_checkbox_demo )<br/>
> [ card ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/基础Widget/gradwidget_demo )<br/>
> [ positionwidget ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/positionwidget )<br/>
> [ stackwidget ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/stackwidget )<br/>
> [ push ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/push_demo )<br/>
> [ push传参 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/push_param_demo )<br/>
> [ ExpansionTile ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/expansion_tile )<br/>
> [ ExpansionPaneList ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/expansionpanelist )<br/>
>  [ 切圆形图片的5个方法 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/border_radius_demo )    
>  [ 使用自定义字体 安卓去除状态栏灰层 渐变色导航栏 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/custom_font_demo )    
> [ Chip FilterChip ChioceChip ActionChip  Divider  DataTable
PaginatedDataTable Stepper ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/mdc_demo )<br/>
> [ 添加引导页面 appBar DatePicker BottomSheet Dialog Stepper 滚动监听 雨滴动画 密码输入框 faceID&TouchID 与webView交互 上拉抽屉 回调 event_bus传值 WillPopScope监听Android物理返回键]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%9F%BA%E7%A1%80Widget/widgets_demo )<br/>



## 布局widget  
> [ rowwidget ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/rowwidget_demo )<br/>
> [ columnwidget ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/columnwidget_demo )<br/>
> [ flex expanded ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/flex_expanded_demo )<br/>
> [ wrap_flow ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%B8%83%E5%B1%80Widget/wrap_flow )<br/>

## 容器widget
> [ Padding ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/padding_demo )<br/>
> [ constrainedbox sizedbox UnconstrainedBox ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/constrainedbox_sizedbox_demo )<br/>
> [ decoratedbox ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/decoratedbox_demo )<br/>
> [ transform ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/transform_demo )<br/>
> [ container ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%AE%B9%E5%99%A8%E7%B1%BBWidget/container )<br/>

## 滚动widget
> [ listview1 竖向 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo )<br/>
> [ listview2 横向]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo2 )<br/>
> [ listview3 动态数据]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/listview_demo3 )<br/>
> [ gridview ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/gridview_demo )<br/>
> [ customscrollview ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/customscrollview_demo )<br/>
> [ scroll ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scroll_widget )<br/>
> [ scroll 滚动控制1 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scrollcontroller_demo )<br/>
> [ container 滚动控制2 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E6%BB%9A%E5%8A%A8%E7%B1%BBWidget/scrollcontroller_demo1 )<br/>

## 功能Widget
>   [ Android双击物理键退出app 主体Theme学习 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/functional_module/lib/main.dart )    <br/>
> [ 模糊效果:filter_widget ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/filter_widget )<br/>
> [ 轻提示 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/tool_tips )<br/>
> [ 弹出框 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/alert_demo
 )<br/>
 > [ Stream RxDart学习 ](  https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%8A%9F%E8%83%BD%E7%B1%BBWidget/stream_demo )<br/>

## 混合开发
 > [ iOS原生中集成Flutter模块 ]( https://zhoushaoting.com/2019/05/29/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~iOS%E5%8E%9F%E7%94%9F%E5%B7%A5%E7%A8%8B%E4%B8%AD%E6%B7%BB%E5%8A%A0Flutter%E6%A8%A1%E5%9D%97/ )<br/>
 > [ Android原生中集成Flutter模块 ]( https://zhoushaoting.com/2019/05/31/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~Android%E5%8E%9F%E7%94%9F%E5%B7%A5%E7%A8%8B%E4%B8%AD%E6%B7%BB%E5%8A%A0Flutter%E6%A8%A1%E5%9D%97/ )<br/>
 > [ flutter_boost学习视频 ](  https://www.bilibili.com/video/av68165113?from=search&seid=6069933847949675176 )<br/>
 > [ flutter_boost教程 ]( https://www.jianshu.com/p/679a642ade52 )<br/>
 > [ flutter_boost源码浅析 ]( https://juejin.im/post/5e61b803f265da57127e526c )<br/>

## 热更新方案
 > [ flutter/issues上关于热更新方案的讨论 ](  https://github.com/flutter/flutter/issues/14330 )<br/>


## 杂类
>  [通知 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E4%BA%8B%E4%BB%B6%E4%B8%8E%E9%80%9A%E7%9F%A5/notification/lib/main.dart )    <br/>
>  [ 事件 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E4%BA%8B%E4%BB%B6%E4%B8%8E%E9%80%9A%E7%9F%A5/pointer/lib/main.dart )    <br/>
>  [ 手势 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%89%8B%E5%8A%BF/destruedetector/lib/main.dart )    <br/>
>  [ 组合Widget 示例1 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/%E7%BB%84%E5%90%88Widget/composite_widget )    <br/>
>  [ 组合Widget 示例2 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/%E7%BB%84%E5%90%88Widget/turnbox )    <br/> 
>  [ custompaint_canvas ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/CustomPaint%E4%B8%8ECanvas/custompaint_canvas )    <br/> 
>  [ progressbar ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E8%87%AA%E5%AE%9A%E4%B9%89Widget/CustomPaint%E4%B8%8ECanvas/progressbar )    <br/> 
>  [ 文件操作 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E8%AF%BB%E5%86%99%E8%AF%B7%E6%B1%82/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C/file_operations/lib/main.dart )    <br/>
>  [ HttpClient ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/HttpClient/httpclient_demo/lib/main.dart )    <br/>
>  [ dio库 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%96%87%E4%BB%B6%E6%93%8D%E4%BD%9C%E4%B8%8E%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82/DioPackage/dio_package_demo/lib/main.dart )    <br/>
>  [ SQLite:sqflite库简单学习 ](https://zhoushaoting.com/2019/03/04/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter%E4%B8%AD%E7%9A%84sqflite%E5%BA%93%E5%AD%A6%E4%B9%A0/ )    <br/>
>  [ json转实体类:json_serializable库学习 ]( https://zhoushaoting.com/2019/03/06/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~json_serializable%E5%BA%93%E5%AD%A6%E4%B9%A0/ )    <br/>
> [ tabBar ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo )<br/>
> [ tabBar1 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo1 )<br/>
> [ tabBar2 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/tabbar_demo2 )<br/>
> [ tabBar3:类今日头条上方tabbar ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/TabBar/top_tabbars_demo )<br/>
> [ 路由管理库fluro学习 ]( https://zhoushaoting.com/2019/03/30/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86%E5%BA%93fluro%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ 路由过渡动画 ]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/push%E5%8A%A8%E7%94%BB/push_animation_demo )<br/>

## state管理
> [ scoped_model学习 ]( https://zhoushaoting.com/2019/02/16/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~scoped_model%E5%AD%A6%E4%B9%A0/ ) <br/> 
> [ redux学习 ]( https://zhoushaoting.com/2019/02/17/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~redux%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ provide学习 ]( https://zhoushaoting.com/2019/03/03/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~provide%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ provider学习 ](http://zhoushaoting.com/2019/09/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~provider%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ mobx学习 ](https://zhoushaoting.com/2019/08/08/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~mobx%E5%BA%93%E5%AD%A6%E4%B9%A0/) <br/>
> [ flutter_bloc学习 ]( https://zhoushaoting.com/2019/03/07/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~flutter_bloc%E5%BA%93%E5%AD%A6%E4%B9%A0/ ) <br/>
> [ fish redux pdf ](https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/Flutter%E5%BA%94%E7%94%A8%E6%A1%86%E6%9E%B6Fish%20Redux.pdf)  <br/>
> [ 阿里fish redux视频 ](https://alivideolive.taobao.com/h5/liveDetail/ff36146a-b106-48f0-8cff-246fa0b62d50) <br/>
> [ 阿里fish redux初识 ](https://www.yuque.com/xytech/flutter/ycc9ni) <br/>
> [ 阿里fish redux中文介绍 ](https://hzgotb.github.io/fish-redux-docs/zh/guide/get-started/) <br/>
> [ fish_redux模版工具FishReduxTemplateForAS-Android Studio ](https://github.com/BakerJQ/FishReduxTemplateForAS) <br/>
> [ fish_redux模版工具fish-redux-template-VScode](https://marketplace.visualstudio.com/items?itemName=huangjianke.fish-redux-template) <br/>
> [ fish_redux Demo(含Tabbar、model、dio、基本传值、component、globalStore、adapter) ](
https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/fish_redux_demo) <br/>
> [ fish_redux Demo1(无Tabbar最简单版本) ](
https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/state%E7%AE%A1%E7%90%86/fish_redux_demo1) <br/>


### 案例
> [ 案例1 选项卡 ](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case1) <br/>
> [ 案例2 输入联想](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case2) <br/>
> [ 案例3 图片增加](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case3) <br/>
> [ 案例4 贝塞尔曲线 ](https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case4) <br/>
> [ 案例5 启动屏 ](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case5) <br/>
> [ 案例6:左滑返回上一页 ]( https://github.com/pheromone/Flutter_learn_demo/blob/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case6/lib/right_back_demo.dart )    <br/>
> [ 案例7 Draggable学习](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case7) <br/>
> [ 案例8 侧滑](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case8) <br/>
> [ 案例9 Slivers全家桶学习](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/case9) <br/>
> [ 案例10 导航条渐隐](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/opacity_nav) <br/>
> [ 案例11 CanVas学习:签名板]( https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/canvas_demo ) <br/>
> [ 案例12 国际化方案]( https://zhoushaoting.com/2019/06/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%9B%BD%E9%99%85%E5%8C%96%E6%95%99%E7%A8%8B%E6%96%B9%E6%A1%88/ ) <br/>
> [ 案例13 动画](https://github.com/pheromone/Flutter_learn_demo/tree/master/%E5%85%B6%E4%BB%96/%E6%A1%88%E4%BE%8B/animation_demo) <br/>
> [ 案例14 Flare学习](https://github.com/pheromone/Flutter_learn_demo/tree/master/其他/案例/flare_learn) <br/>
> [ 案例15 自定义Dialog和基本的组件封装](https://zhoushaoting.com/2019/11/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E8%87%AA%E5%AE%9A%E4%B9%89Dialog(%E5%9F%BA%E6%9C%AC%E7%9A%84%E7%BB%84%E4%BB%B6%E5%B0%81%E8%A3%85)/) <br/>



