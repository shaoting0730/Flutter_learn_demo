import 'package:flutter/material.dart';
import '../models/showing.dart';
import '../widgets/shadow_decoration.dart';
import '../pages/add_client_page.dart';

class ClientCell extends StatefulWidget {
  final ShowingProfileModel model;
  final VoidCallback modifySuccessCallback;
  ClientCell({this.model, this.modifySuccessCallback});

  @override
  State<ClientCell> createState() {
    return ClientCellState();
  }

}

class ClientCellState extends State<ClientCell> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: shadowDecoration(),
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildClientInfo(context),
              Container(
                height: 1, 
                width: double.infinity,
                color: Color(0xFFD8D8D8)
              ),
              _buildHouseKeepingRecords()
            ],
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: InkWell(
            onTap: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AddClientPage(
                  addSuccessCallback: () {
                    if(widget.modifySuccessCallback != null) {
                      widget.modifySuccessCallback();
                    }
                  },
                  model: widget.model,
                )));
            },
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset('assets/ic_edit.png'),
            )
          )
        )
      ]
    );
  }

  Widget _buildClientInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.model.CustomerName, style: TextStyle(fontSize: 16, color: Color(0xFF536282), fontWeight: FontWeight.w600)),
                Text(widget.model.PhoneNumber, style: TextStyle(fontSize: 14, color: Color(0xFF99A2B4))),
                Text(widget.model.Email, style: TextStyle(fontSize: 14, color: Color(0xFF99A2B4)))
              ],
            )
          )
        ],
      ),
    );
  }


  Widget _buildHouseKeepingRecords() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      child: Text('There are ' + widget.model.TotalShowingRequests.toString() + ' house-keeping records> ', style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)),),
    );
  }
}