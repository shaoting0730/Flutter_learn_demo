import 'package:flutter/material.dart';
import 'dart:ui'; //引入ui库，因为ImageFilter Widget在这个里边。

class FilterImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      //重叠的Stack Widget，实现重贴
      children: <Widget>[
        ConstrainedBox(
            //约束盒子组件，添加额外的限制条件到 child上。
            constraints: const BoxConstraints.expand(), //限制条件，可扩展的。
            child: Image.network(
                'https://ww1.sinaimg.cn/large/0065oQSqly1ftdtot8zd3j30ju0pt137.jpg',
                )),
        Center(
          child: ClipRect(
            //裁切长方形
            child: BackdropFilter(
              //背景滤镜器
              filter: ImageFilter.blur(
                  sigmaX: 5.0, sigmaY: 5.0), //图片模糊过滤，横向竖向都设置5.0
              child: Opacity(
                //透明控件
                opacity: 0.5,
                child: Container(
                  // 容器组件
                  width: 400.0,
                  height: 700.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200), //盒子装饰器，进行装饰，设置颜色为灰色
                  child: Center(
                    child: Text(
                      'fuck',
                      style: Theme.of(context).textTheme.display3, //设置比较酷炫的字体
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
