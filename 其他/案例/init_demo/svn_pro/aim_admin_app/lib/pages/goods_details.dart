/*
* 商品详情
* */

import 'package:flutter/material.dart';

class GoodsDetailsPage extends StatefulWidget {
  @override
  _GoodsDetailsPageState createState() => _GoodsDetailsPageState();
}

class _GoodsDetailsPageState extends State<GoodsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('销售素材'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              '众明星的助眠好物品🌛',
              style: TextStyle(fontSize: 25),
            ),
          ),
          _goodsTitleWidget('assets/one.png', 'thisworks 助眠喷雾'),
          _goodsTitleWidget('assets/two.png', '荣获超过100项国际美妆奖'),
          Text(
              '      99%天然成分，由薰衣草，洋甘菊，及岩兰草配比而成。不含药物、合成香料、转基因生物等有害成分，89%用户更快入睡[玫瑰]失眠很多原因是因为夜晚精神紧张、兴奋、抑郁、恐惧、焦虑等精神因素引起，睡前饮食过饱、睡前饮茶和咖啡也会引起失眠，如果因为精神因素，这款助眠喷雾可以起到舒缓神经的作用，慢慢人放松下来之后，就很容易入眠了🌛'),
          Wrap(
            children: <Widget>[
              Image.asset(
                'assets/goods1.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
              Image.asset(
                'assets/goods2.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
              Image.asset(
                'assets/goods3.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ],
          )
        ],
      ),
    );
  }

  _goodsTitleWidget(img, txt) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Image.asset(img),
          Text(
            txt,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
