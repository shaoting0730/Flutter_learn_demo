import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import '../models/houseproduct.dart';
class FormRoom extends StatefulWidget {

  final HouseModel model;
  FormRoom({this.model});

  @override
  State<StatefulWidget> createState() {
    return FormRoomState();
  }  
}

class FormRoomState extends State<FormRoom> {
   @override
  Widget build(BuildContext context) {
     List<Widget> childrenList = new List<Widget>();
     childrenList.add(_buildHeader());
     if(widget.model.houseInfo.RoomDetails!=null)
     {
       for(int i=0;i<widget.model.houseInfo.RoomDetails.length;i++)
       {
         String Description = "";
         RoomDetailsModel room = widget.model.houseInfo.RoomDetails[i];
         if(room.Description1!="")
           Description += room.Description1;
         if(room.Description2!="")
           Description += " "+ room.Description2;
         if(room.Description3!="")
           Description += " "+ room.Description3;
         childrenList.add(_buildCell(room.Room, room.Level, room.Length==0?"N/A":room.Length.toString(), room.Width==0?"N/A":room.Width.toString(), Description, true));
       }
     }

    return Container(
      child: Column(
        children: childrenList,
      )
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text("Room", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            )
          ),
          Container(
            width: 70,
            alignment: Alignment(0, 0),
            child: Text("Floor", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          Container(
            width: 70,
            alignment: Alignment(0, 0),
            child: Text("Length", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          Container(
            width: 70,
            alignment: Alignment(0, 0),
            child: Text("Width", style:TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }

  Widget _buildCell(String room, String floor, String length, String width, String description, bool dark) {
    Color backgroundColor = dark? Color(0xFFF0F0F0): Colors.white;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(room, style:TextStyle(fontSize: 14)),
                )
              ),
              Container(
                width: 70,
                alignment: Alignment(0, 0),
                child: Text(floor, style:TextStyle(fontSize: 14)),
              ),
              Container(
                width: 70,
                alignment: Alignment(0, 0),
                child: Text(length, style:TextStyle(fontSize: 14)),
              ),
              Container(
                width: 70,
                alignment: Alignment(0, 0),   
                child: Text(width, style:TextStyle(fontSize: 14)),
              )
            ],
          ),
          SizedBox(height: 5,),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(description, style:TextStyle(fontSize: 14))
          )
        ]
      )
    );
  }

}