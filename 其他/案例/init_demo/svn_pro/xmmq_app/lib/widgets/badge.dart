import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Badge extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;

  Badge({Key key, this.icon, this.text, this.onPressed}) : super(key: key);

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: widget.onPressed,
            child: Stack(
              children: Utils.noNull([
                widget.icon,
                widget.text == null
                    ? null
                    : Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 175, 76, 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${widget.text}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
