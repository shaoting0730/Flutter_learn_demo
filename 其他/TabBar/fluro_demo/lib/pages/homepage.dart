import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../routers/application.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  List<String> dataList = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      dataList.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: (){
              Application.router.navigateTo(context, "./detail?id=${dataList[index]}", transition: TransitionType.inFromLeft);
          },
          title: Text(dataList[index] + '👌'),
        );
      },
    );
  }
}
