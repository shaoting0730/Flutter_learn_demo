import 'package:flutter/material.dart';
import 'avatar.dart';
import 'shadow_decoration.dart';


class ContactCard extends StatefulWidget {
  final String avatar;
  final String username;
  final String title;
  final String contact;
  final String content;

  ContactCard({this.avatar, this.username, this.title, this.content, this.contact});

  @override
  State<StatefulWidget> createState() {
    return _ContactCardState();
  }
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    var content = List<Widget>();
    if(widget.username != null && widget.username.length > 0) {
      content.add(Text(widget.username ,style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),));
    }

    if(widget.title != null && widget.title.length > 0) {
      if(content.length > 0) {
          SizedBox(height: 5,);
      }
      content.add(Text(widget.title ,style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)); 
    }

    if(widget.content != null && widget.content.length > 0) {
      if(content.length > 0) {
        SizedBox(height: 5,);
      }
      content.add(Container(
          width: MediaQuery.of(context).size.width - 120,
          child: Text(widget.content,style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)), textAlign: TextAlign.left, softWrap: true,),
        )
      );
    
    }

  if(widget.contact != null && widget.contact.length >0) {
    if(content.length > 0) {
      SizedBox(height: 2,);
    }
    content.add(Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(widget.contact,style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),textAlign: TextAlign.left, softWrap: true,),
                )
              );
  }

    return Container(
      decoration: shadowDecoration(),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Avatar(avatar: widget.avatar),
            SizedBox(width: 15,),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content
              ),
            )
          ],
        )
      )
    );
  }
}