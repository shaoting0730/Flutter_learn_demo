import 'package:flutter/material.dart';


AlertDialog buildAddNewPlanDialog(BuildContext context) {
  return AlertDialog (
    contentPadding:const EdgeInsets.all(0),
    content: Container(
      width: 335,
      height: 390,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDialogTitleArea(),
          _buildInputField("Name"),
          _buildInputField("Phone number"),
          _buildInputField("Note"),
          Container( 
            padding: const EdgeInsets.fromLTRB(88, 24, 88, 24),
            child: ButtonTheme(
              minWidth: 160,
              height: 48,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text("Finish", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14)),
                color: Colors.red,
                onPressed: () {
                },
              )
            )
          )
        ],
      )
    ),
  );  
}


Widget _buildDialogTitleArea() {
  return Container(
    height: 65,
    alignment: Alignment(0.0, 0.0),
    color: Color(0xFF536282),
    child: Text("Add a new plan", style: TextStyle(color: Colors.white, fontSize: 18)),
  );
}

Widget _buildInputField(String title) {
  return Container(
    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
    child: Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: title
          ),
        )
      ],
    ),
  );
}