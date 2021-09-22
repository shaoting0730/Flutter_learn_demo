import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import '../service/serviceapi.dart';

class PlanTimeHeader extends StatefulWidget {

  final PlanModel model;
  final bool roundCorner;

  PlanTimeHeader({this.model, this.roundCorner});

  @override
  State<StatefulWidget> createState() {
    return PlanTimeHeaderState();
  }

}

class PlanTimeHeaderState extends State<PlanTimeHeader> {

  Color backgroundColor;
  String actionText;
  Color tipBackgroundColor;
  String tipText;
  String displayIcon;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    switch (widget.model.status) {
      case PlanStatus.confirmed:
        DateTime startTime = TicksToDateTime(widget.model.ShowingRequest.ScheduledStartTime);
        DateTime endTime = TicksToDateTime(widget.model.ShowingRequest.ScheduledEndTime);
        if (DateTime.now().millisecondsSinceEpoch >= startTime.millisecondsSinceEpoch && DateTime.now().millisecondsSinceEpoch <= endTime.millisecondsSinceEpoch) {
          backgroundColor =Color(0xFF66D695);
          tipBackgroundColor = Color(0xFF98E5B9);
          actionText = "On Time";
          tipText = "Appointment Required Confirme with " + widget.model.confirmedBy;
          displayIcon = 'assets/icon_home_confirmed.png';
        }
        else
        {
          backgroundColor =Color(0xFF536282);
          tipBackgroundColor = Color(0xFF7A88A7);
          actionText = "Confirmed";
          tipText = "Appointment Required Confirme with " + widget.model.confirmedBy;
          displayIcon = 'assets/icon_home_confirmed.png';
        }
        break;
      case PlanStatus.timechanged:
        backgroundColor =Color(0xFFE77F7D);
        tipBackgroundColor = Color(0xFFEFB8B7);
        actionText = "Time Changed";
        tipText = "Housekeeper is busy, please change time";
        displayIcon = 'assets/icon_home_busy.png';
        break;
      case PlanStatus.cancelled:
        backgroundColor =Color(0xFFC5C2C2);
        tipBackgroundColor = Color(0xFFD1D1D1);
        actionText = "Cancelled";
        tipText = "Failure of application, resubmission";
        displayIcon = 'assets/icon_home_failed.png';
        break;
      case PlanStatus.waiting:
        backgroundColor =Color(0xFF8AB6CA);
        tipBackgroundColor =Color(0xFFA8CCDC);
        actionText = "Waiting";
        tipText = "Awaiting audit";
        displayIcon = 'assets/icon_home_waiting.png';
        break;
      case PlanStatus.completed:
        backgroundColor =Color(0xFFA0A4AC);
        tipBackgroundColor =Color(0xFFB4B9C3);
        actionText = "Completed";
        tipText = "House inspection";
        displayIcon = 'assets/icon_home_completed.png';
        break;
      case PlanStatus.decline:
        backgroundColor =Color(0xFFC5C2C2);
        tipBackgroundColor =Color(0xFFD1D1D1);
        actionText = "Decline";
        tipText = "The application was rejected and resubmitted";
        displayIcon = 'assets/icon_home_decline.png';
        break;
      default:
        actionText = "unknown";
    }
    return Container(
      child: Column(
        children: <Widget>[
          _buildHeaderTimeArea(),
          _buildHeaderTip()
        ],
      ),
    );
  }
  Widget _buildHeaderTip() {
    return Container(
      height: 22,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      color: tipBackgroundColor,
      child: Text(tipText, style: TextStyle(color: Colors.white, fontSize: 12),),
    );
  }

  Widget _buildHeaderTimeArea() {

    var borderRadius = widget.roundCorner ? BorderRadius.only(topRight: Radius.circular(20.0)) : BorderRadius.all(Radius.circular(0));
    var padding = widget.roundCorner ? EdgeInsets.fromLTRB(15, 5, 15, 5) : EdgeInsets.fromLTRB(15, 15, 15, 15);
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      padding: padding,
      
      child: Row(
        children: <Widget>[
          Image.asset(displayIcon),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.model.date, style: TextStyle(color: Colors.white, fontSize: 14)),
                  Text(widget.model.startAt + " - " + widget.model.endAt, style: TextStyle(color:Colors.white, fontSize: 14),)
                ]
              )
            )
          ),
          Text(actionText, style: TextStyle(color: Colors.white, fontSize: 14),)
        ],
      )
    );
  }
  

}