import 'package:flutter/material.dart';


typedef ContextCallback = void Function(BuildContext context);

class EmptyAddPlanWidget extends StatefulWidget {

  final ContextCallback onAddPressed;

  EmptyAddPlanWidget({this.onAddPressed});

  @override
  State<EmptyAddPlanWidget> createState() {
    return _EmptyAddPageWidgetState();
  }

}

class _EmptyAddPageWidgetState extends State<EmptyAddPlanWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 80),
          Text("No plan?"),
          SizedBox(height: 38),
          ButtonTheme(
            minWidth: 160,
            height: 48,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text("Add", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14)),
              color: Colors.red,
              onPressed: () {
                widget.onAddPressed(context);
              },
            )
          )
        ],
      )
    );
  }
}