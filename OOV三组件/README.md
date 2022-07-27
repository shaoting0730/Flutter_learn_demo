## Flutter布局和渲染是完全独立的两个过程

### Opacity
主要是修改子组件的不透明度，注意的是修改不透明度是一个比较消耗性能的操作。因为每当需要渲染半透明的效果时，Flutter必须先将子组件渲染至缓冲区，再对其修改透明度，最后才能渲染。其中，当opacity值为0.0或者1.0时，Flutter会进行相应优化，不用担心性能：当opacity为1.0时，即代表完全可见，即等同没有Opacity组件，当opacity0.0时，组件完全不可见，但位置仍占着，仍可以通过GlobalKey获取到其大小。开发中，推荐使用color属性，直接传入透明的颜色实现亦可。
### Offstage
直接不显示/显示其子组件，可以通过GlobalKey获取到其布局的尺寸大小，但其位置没了，不渲染.
### Visibility
控制子组件是否可见，默认为显示。如果为false，代表其不可见，是真的不可见，无法使用GlobalKey获取其大小，布局和渲染都没有。


![image](https://github.com/pheromone/Flutter_learn_demo/blob/master/OOV%E4%B8%89%E7%BB%84%E4%BB%B6/OOV-result.jpg) <br/>
