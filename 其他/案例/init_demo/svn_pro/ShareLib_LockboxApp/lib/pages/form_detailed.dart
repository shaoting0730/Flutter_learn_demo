import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';


class FormDetailed extends StatefulWidget {

  final HouseModel model;
  FormDetailed({this.model});

  @override
  State<StatefulWidget> createState() {
    return FormDetailedState();
  }
}

class FormDetailedState extends State<FormDetailed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildCell("Sale Or Lease:", widget.model.houseInfo.SaleOrLease),
          _buildCell("Basement:", widget.model.houseInfo.Basement),
          _buildCell("Pool:", widget.model.houseInfo.Pool),
          _buildCell("AirConditioning:", widget.model.houseInfo.AirConditioning),
          _buildCell("Heat:", widget.model.houseInfo.HeatType + " " +widget.model.houseInfo.HeatSource),
          _buildCell("Front On:", widget.model.houseInfo.FrontingOnNSEW),
        ],
      )
    );
  }

  Widget _buildCell(String title, String value) {
    return Container(
      height: 28,
      child: Row(
        children: <Widget>[
          Container(
            width: 200,
            child: Text(title, style: TextStyle(fontSize: 14),),
          ),
          Container(
            child: Text(value, style: TextStyle(fontSize: 14),),
          ),
          
        ],
      )
    );

  }
}