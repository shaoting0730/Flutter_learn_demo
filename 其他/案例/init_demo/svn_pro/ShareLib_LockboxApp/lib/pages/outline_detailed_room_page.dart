import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import 'form_outline.dart';
import 'form_detailed.dart';
import 'form_room.dart';

class OutlineDetailedRoomPage extends StatefulWidget {
  final HouseModel model;

  OutlineDetailedRoomPage({this.model});

  @override
  State<StatefulWidget> createState() {
    return OutlineDetailedRoomPageState();
  }
}

class OutlineDetailedRoomPageState extends State<OutlineDetailedRoomPage> with SingleTickerProviderStateMixin {

  FormOutline outlineForm;
  FormDetailed detailedForm;
  FormRoom roomForm;
  TabController _controller;

  List<Widget> _tabs;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _tabs = [
      Tab(text: "Outline",),
      Tab(text: "Detailed"),
      Tab(text: "Room"),
    ];
    
    outlineForm = FormOutline(model: widget.model,);
    detailedForm = FormDetailed(model: widget.model,);
    roomForm = FormRoom(model: widget.model,);
    _currentPage = outlineForm;
    _controller = TabController(length: 3, initialIndex:0, vsync: this)..addListener(() {
      setState(() {
        switch(_controller.index) {
          case 0:
          _currentPage = outlineForm;
          break;
          case 1:
          _currentPage = detailedForm;
          break;
          case 2:
          _currentPage = roomForm;
          break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.black.withAlpha(80),
              )
            )
          ),
          Container(
            height: 490,
            width: double.infinity,
            child: DefaultTabController(
              length: 3,
              child: Material(
                child: Column(
                  children:<Widget>[
                    DefaultTabController(
                      length: 2,
                      child: TabBar(
                        controller: _controller,
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: _tabs,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: _currentPage
                      ),
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }
}