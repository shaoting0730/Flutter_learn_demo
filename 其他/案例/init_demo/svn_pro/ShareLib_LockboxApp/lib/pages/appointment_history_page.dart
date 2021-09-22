import 'package:flutter/material.dart';
import 'base_page.dart';
import '../models/showing.dart';
import '../widgets/my_client_records_cell.dart';
import '../widgets/empty_state.dart';
import '../models/ui/client_model.dart';
import '../service/serviceapi.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryPage extends BasePage {

  final List<ShowingRequestModel> models;
  final String clientName;
  AppointmentHistoryPage({this.models, this.clientName = ""});

  @override
  State<StatefulWidget> createState() {
    return AppointmentHistoryPageState();
  }

}

class AppointmentHistoryPageState extends BasePageState<AppointmentHistoryPage> {

  List<MyClientRecordCellModel> _models;

  @override
  void initState() {
    super.initState();

    title = "Appointment History";
    _models = _convert();
  }

  @override
  Widget pageContent(BuildContext context) {
    if(widget.models.length == 0) {
      return EmptyRecord();
    }

    return Container(
      color: Color(0xFFF0F0F0),
      child: ListView.builder(
        itemCount: _models.length,
        itemBuilder: (BuildContext context, int index) {
          var model = _models[index];
          if(model.type == 0) {
            return Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Text(model.datetime, style: TextStyle(fontSize: 14))
            );
          } else {
            return MyClientRecordCell(model: model.model);
          }
        },
      ),
    );
  }

  List<MyClientRecordCellModel> _convert() {

    List<MyClientRecordCellModel> result = List<MyClientRecordCellModel>();

    String previousDate = "";
    widget.models.forEach((model) {
      var format = new DateFormat('d/MM/y', 'en');
      var date = format.format(TicksToDateTime(model.ScheduledStartTime));

      if(date != previousDate) {
        result.add(MyClientRecordCellModel(type: 0, datetime: date));
        previousDate = date;
      } 
      result.add(MyClientRecordCellModel(type: 1, model: model));
      
    });

    return result;
  }

}