##  flutter启动流程分析

1、binding初始化(ensureInitialized)  <br/>
2、绑定根节点(scheduleAttachRootWidget)   <br/>
3、绘制热身帧(scheduleWarmUpFrame)   <br/>

一:冷启动(从零开始启动，花费时间长，重新编译，相当于第一次启动一个APP） <br/>
二:热重载(主要是执行build方法，主要就是基于JIT实现，setState的效果，类似r)  <br/>
三:热重启(重新运行整个app，是重新运行，而不是第一次运行，类似于R)  <br/>

> [Flutter 启动流程]( https://www.jianshu.com/p/8b782b8da96e ) <br/>
> [ Flutter启动流程源码分析 ](https://www.jianshu.com/p/21f8d239a375) <br/>


