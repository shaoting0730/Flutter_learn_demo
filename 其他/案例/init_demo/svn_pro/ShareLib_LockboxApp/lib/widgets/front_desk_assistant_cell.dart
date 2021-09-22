import 'package:flutter/material.dart';
import '../models/loginmodel.dart';
import '../widgets/shadow_decoration.dart';

class FrontDeskAssistantCell extends StatefulWidget {
  final ImpersonationorInfoModel model;
  FrontDeskAssistantCell({this.model});

  @override
  State<FrontDeskAssistantCell> createState() {
    return FrontDeskAssistantCellState();
  }

}

class FrontDeskAssistantCellState extends State<FrontDeskAssistantCell> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: shadowDecoration(),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildClientInfo(context),
            ],
          ),
        ),
      ]
    );
  }

  Widget _buildClientInfo(BuildContext context) {

    List<Widget> list = List<Widget>();
    if(widget.model.FirstName != "" && widget.model.LastName != "") {
      list.add(Text(widget.model.FirstName + " " + widget.model.LastName, style: TextStyle(fontSize: 16, color: Color(0xFF536282), fontWeight: FontWeight.w600)));
    }
    if(widget.model.PhoneNumber != null) {
      list.add(Text(widget.model.PhoneNumber, style: TextStyle(fontSize: 14, color: Color(0xFF99A2B4))),);
    }
    if(widget.model.Email != null) {
      list.add(Text(widget.model.Email, style: TextStyle(fontSize: 14, color: Color(0xFF99A2B4))));
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            )
          )
        ],
      ),
    );
  }

}