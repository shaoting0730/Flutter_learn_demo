import 'package:flutter/material.dart';
import 'package:test_demo/model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MultiCheckPage extends StatefulWidget {
  const MultiCheckPage({Key? key}) : super(key: key);

  @override
  State<MultiCheckPage> createState() => _MultiCheckPageState();
}

class _MultiCheckPageState extends State<MultiCheckPage> {
  final List<UserModel> _list = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() {
    for (var i = 0; i < 10; i++) {
      var json = {'userName': '名字$i', 'status': false};
      UserModel model = UserModel.fromJson(json);
      _list.add(model);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            _list.forEach((element) {
              print('${element.userName} ${element.status}');
            });
          },
          child: const Text('输出值'),
        ),
      ),
      body: EasyRefresh(
        onRefresh: () async {
          _list.clear();
          _getData();
        },
        onLoad: () async {
          _getData();
        },
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$index'),
                Checkbox(
                  value: _list[index].status,
                  onChanged: (e) {
                    _list[index].status = e;
                    setState(() {});
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
