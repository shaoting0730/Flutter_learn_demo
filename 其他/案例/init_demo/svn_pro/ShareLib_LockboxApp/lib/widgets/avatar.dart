import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String avatar;
  Avatar({this.avatar});
  @override
  State<StatefulWidget> createState() {
    return _AvatarState();
  }

}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    var image = widget.avatar != null && widget.avatar.length > 0 ? NetworkImage(widget.avatar): AssetImage('assets/icon_details_people.png');
    return Container(
      decoration: BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: image,
        )
      ),
      height: 38,
      width: 38,
    );
  }

}