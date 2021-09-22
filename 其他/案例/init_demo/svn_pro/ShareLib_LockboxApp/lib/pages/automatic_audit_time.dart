import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'base_page.dart';
import 'add_audit_time_page.dart';
import '../models/ui/plan_model.dart';
import '../models/showing.dart';
import '../widgets/house_card.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/audit_time_cell.dart';
import '../service/serviceapi.dart';


class AutomaticAuditTimePage extends BasePage {

  final PlanModel model;

  AutomaticAuditTimePage({this.model}) ;

  @override
  State<StatefulWidget> createState() {
    return AutomaticAuditTimePageState();
  }

}

class AutomaticAuditTimePageState extends BasePageState<AutomaticAuditTimePage> {

  @override
  void initState() {
    super.initState();
    title = "Showing Auto Confirm Setting";
  
  }

  @override
  Widget pageContent(BuildContext context) {

    var contentView = List<Widget>();
    contentView.add(_buildHouseCard());
    widget.model.house.showingAutoConfirmSettingList.forEach((element){
      contentView.add(
        Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: AuditTimeCell(model: element, onValueChanged: (){
                _onTimeValueChanged(context);
              }),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                _onDelete(context, element);
                setState(() {
                  widget.model.house.showingAutoConfirmSettingList.remove(element);
                });

                },
              ),
            ],
          )
        )
       );
    });

    return Container(
      color: Color(0xFFF0F0F0),
      child: Stack(
        alignment: Alignment(0, 0),
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: contentView,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: 200,
              height: 44,
              child: RaisedButton(
                child: Text("Add"),
                onPressed: () {
                  _onTapAddButton(context);
                },
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.red,)
                )
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildHouseCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
        width: double.infinity,
        decoration: shadowDecoration(),
        child: HouseCard(model: widget.model.house, actionButtons: [])
      )  
    );
  }

  void _onTapAddButton(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddAuditTimePage(model: widget.model.house)));
  }

  void _onTimeValueChanged(BuildContext context ) async {

    displayProgressIndicator(true);
    await UserServerApi().UpdateShowingAutoConfirmSetting(context, widget.model.house.showingAutoConfirmSettingList);
    displayProgressIndicator(false);
    
  }

  void _onDelete(BuildContext context, ShowingAutoConfirmSettingModel request) async {
    displayProgressIndicator(true);
    await UserServerApi().DeleteShowingAutoConfirmSetting(context, request.Guid);
    displayProgressIndicator(false);
  }
}