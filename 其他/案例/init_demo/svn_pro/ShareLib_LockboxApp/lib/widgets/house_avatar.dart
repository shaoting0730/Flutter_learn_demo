import 'package:flutter/material.dart';


class HouseAvatar extends StatefulWidget {

  final String thumbnailUrl;
  
  HouseAvatar({this.thumbnailUrl});

  @override
  State<StatefulWidget> createState() {
    return HouseAvatarState();
  }

}

class HouseAvatarState extends State<HouseAvatar> {

  @override
  Widget build(BuildContext context) {
    var image = widget.thumbnailUrl == null ? Image.asset('assets/icon_house_empty.png') : Image.network(widget.thumbnailUrl, fit:BoxFit.cover);
    return Container(
      height: 80,
      width: 80,
      child: image,
    );
  }
  

}