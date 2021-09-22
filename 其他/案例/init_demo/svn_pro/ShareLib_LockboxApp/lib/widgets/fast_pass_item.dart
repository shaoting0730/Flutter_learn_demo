import 'package:flutter/material.dart';

class FastPassItem extends StatelessWidget {

  final Image icon;
  final String title;
  final int badge;

  FastPassItem({this.icon, this.title, this.badge=0});

  @override
  Widget build(BuildContext context) {

    var list  = List<Widget>();
    
    list.add(
      Container(
        alignment: Alignment(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 15,),
            icon,
            SizedBox(height: 8,),
            Container(
              child: Text(title, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w200)),
            )        
          ],
        )
      ),
    );

    if(badge > 0) {
      
      list.add(
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 16,
            width: 16,
            child: Text(badge.toString(), style: TextStyle(fontSize: 10, color: Colors.white)),
          ),
        )
      );
    }
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment(0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xFF2D2D2D),
            ),
            height: 75,
            width: 75,
            child: Stack(
              children: list,
            ) 
          )
        )
      );
  }
}