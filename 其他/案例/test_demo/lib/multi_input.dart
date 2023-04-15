import 'package:flutter/material.dart';

class MultiInputPage extends StatefulWidget {
  const MultiInputPage({super.key});
  @override
  State<MultiInputPage> createState() => _MultiInputPageState();
}

class _MultiInputPageState extends State<MultiInputPage> {
  final List<String> _list = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() {
    for (var i = 0; i < 10; i++) {
      _list.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
        onTap: () {
          print(_list);
        },
        child: Text('输出值'),
      )),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text('$index'),
                TextField(
                  decoration: InputDecoration(
                    hintText: '输入$index',
                  ),
                  onChanged: (e) {
                    _list[index] = e;
                    setState(() {});
                  },
                )
              ],
            );
          }),
    );
  }
}
