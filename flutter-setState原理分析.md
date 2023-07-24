##  flutter:setState原理分析

```
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
```

![image](https://github.com/pheromone/Flutter_learn_demo/blob/master/setState.png) <br/>
# markNeedsBuild

> [Flutter UI基础 - setState更新原理和流程]( https://blog.csdn.net/shanghaibao123/article/details/107495184 ) <br/>
> [Flutter的setState原理详解]( https://blog.csdn.net/xiatiandefeiyu/article/details/105489103 ) <br/>
> [Flutter中关于setState的理解(三)]( https://www.jianshu.com/p/24018d234210 ) <br/> 
> [Flutter的setState更新原理和流程](https://zhuanlan.zhihu.com/p/271803637 ) <br/>
> [ Flutter 必知必会系列 —— Element 更新实战 ]( https://juejin.cn/post/7058539230288412679 ) <br/>



