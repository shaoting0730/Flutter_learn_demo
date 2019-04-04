import 'package:flutter/material.dart';

class ChipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChipDemoWidget(),
    );
  }
}

class ChipDemoWidget extends StatefulWidget {
  @override
  _ChipDemoWidgetState createState() => _ChipDemoWidgetState();
}

class _ChipDemoWidgetState extends State<ChipDemoWidget> {
  List<String> _tags = ['apple', 'branar', 'lmemon'];
  List<String> _tags1 = ['apple', 'branar', 'lmemon'];

  String _action = '';
  List<String> _selected = [];
  String _choice = 'lmemon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chip')),
      body: Wrap(
        spacing: 8.0,
        children: <Widget>[
          Chip(
            label: Text('html'),
          ),
          Chip(
            label: Text('Css'),
            backgroundColor: Colors.orange,
          ),
          Chip(
            label: Text('JS'),
            avatar: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text('走'),
            ),
          ),
          Divider(
            color: Colors.yellow,
            height: 20.0,
          ),
          Chip(
            label: Text('大法好'),
            avatar: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://ws1.sinaimg.cn/large/0065oQSqly1g0ajj4h6ndj30sg11xdmj.jpg',
              ),
            ),
          ),
          Chip(
            label: Text('删库跑人法'),
            onDeleted: () {},
            deleteIcon: Icon(Icons.delete),
            deleteIconColor: Colors.red,
          ),
          Divider(
            color: Colors.red,
            height: 20.0,
          ),
          Wrap(
            spacing: 8.0,
            children: _tags1.map((tag) {
              return Chip(
                label: Text(tag),
                onDeleted: () {
                  setState(() {
                    _tags1.remove(tag);
                  });
                },
              );
            }).toList(),
          ),
          Divider(
            color: Colors.yellow,
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            child: Text('ActionChip : $_action'),
          ),
          Wrap(
            spacing: 8.0,
            children: _tags.map((tag) {
              return ActionChip(
                label: Text(tag),
                onPressed: () {
                  setState(() {
                    _action = tag;
                  });
                },
              );
            }).toList(),
          ),
          Divider(
            color: Colors.black,
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            child: Text('FilterChip : ${_selected.toString()}'),
          ),
          Wrap(
            spacing: 8.0,
            children: _tags.map((tag) {
              return FilterChip(
                label: Text(tag),
                selected: _selected.contains(tag),
                onSelected: (value){
                   if(_selected.contains(tag)){
                      setState(() {
                     _selected.remove(tag);
                  });
                   } else {
                     setState(() {
                     _selected.add(tag);
                  });
                   }
                },
              );
            }).toList(),
          ),
          Divider(
            color: Colors.orange,
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            child: Text('ChoiseChip : $_choice'),
          ),
          Wrap(
            spacing: 8.0,
            children: _tags.map((tag) {
              return ChoiceChip(
                label: Text(tag),
                selectedColor: Colors.black,
                selected: _choice == tag,
                onSelected: (value){
                  setState(() {
                    _choice = tag;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.restore),
        onPressed: () {
          setState(() {
            _tags = ['apple', 'branar', 'lmemon'];
            _tags1 = ['apple', 'branar', 'lmemon'];
            _selected = [];
            _action = '';
            _choice = 'lmemon';
          });
          
        },
      ),
    );
  }
}
