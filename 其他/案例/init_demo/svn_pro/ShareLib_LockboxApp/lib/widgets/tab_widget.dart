import 'package:flutter/material.dart';


class TabItem extends StatefulWidget {
  final String displayName;
  final Image displayIcon;
  final bool actived;

  TabItem({this.displayIcon, this.displayName, this.actived});

  @override
  State<TabItem> createState() {
    return TabItemState();
  }

}

class TabItemState extends State<TabItem> {
  
  @override
  Widget build(BuildContext context) {
    if(widget.actived) {
      return _buildActive();
    } else {
      return _buildInactive();
    }
  }

  Widget _buildActive() {
    return Container(
      height: 40,
      padding: const EdgeInsets.fromLTRB(23, 10, 23, 10),
      child: Text(widget.displayName, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),),
      decoration: BoxDecoration(
        color: Color(0xFF536282),
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(20), topRight: const Radius.circular(20))
      ),
    );
  }

  Widget _buildInactive() {
    return Container(
      height: 40,
      width: 40,
      child: widget.displayIcon,
      decoration: BoxDecoration(
        color: Color(0xFFFF3C38),
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(20), topRight: const Radius.circular(20))
      ),
    );
  }
}