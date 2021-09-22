import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import './plan_time_header.dart';
import './house_card.dart';
import '../service/serviceapi.dart';

typedef OnDismissed = void Function(PlanModel model);
typedef OnRequestMessagePageRefresh = void Function(String errorMessage);
class PlanCard extends StatefulWidget {

  final PlanModel model;
  final bool roundCorner;
  final OnDismissed onDismissed;
  final OnRequestMessagePageRefresh onRequestMessagePageRefresh;
  PlanCard({this.model,this.onRequestMessagePageRefresh, this.roundCorner = true, this.onDismissed});

  @override
  State<StatefulWidget> createState() {
    return _PlanCardState();
  }
}

class _PlanCardState extends State<PlanCard> {

  @override
  Widget build(BuildContext context) {
    var borderRadius = widget.roundCorner ? BorderRadius.only(topRight: Radius.circular(20.0)) : BorderRadius.all(Radius.circular(0));
    Widget card = HouseCard(model: widget.model.house);
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 2.0, // has the effect of softening the shadow
            spreadRadius: 2.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ]
      ),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: <Widget>[
          PlanTimeHeader(model: widget.model, roundCorner: widget.roundCorner,),
          card
        ],
      ),
    );
  }
  
  void _cancelAppointment(direction) async
  {
    if(widget.model.ShowingRequest==null)
      return;
    if (await _requestPrompt(context,'Are you sure to cancel the application?')  == false) {
      return;
    }
    widget.model.ShowingRequest.RequestStatus = 4;
    bool bRet = await UserServerApi().UpdateShowingSchedule(context, [widget.model.ShowingRequest]);
    if(widget.onRequestMessagePageRefresh != null) {
      if(bRet) {
        widget.onRequestMessagePageRefresh(null);
      }
    }
    if(widget.onDismissed != null) {
      widget.onDismissed(widget.model);
    }
  }

  Future<bool> _requestPrompt(BuildContext context, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: const Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

}
