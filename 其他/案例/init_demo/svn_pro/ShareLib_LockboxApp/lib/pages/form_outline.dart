import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';

class FormOutline extends StatefulWidget{

  final HouseModel model;
  FormOutline({this.model});

  @override
  State<StatefulWidget> createState() {
    return FormOutlineState();
  }
}

class FormOutlineState extends State<FormOutline> {
 @override
  Widget build(BuildContext context) {
   String bedRoomsTotal = widget.model.houseInfo.BedRooms.toString();
   if(widget.model.houseInfo.BedRoomsPossible>0)
     bedRoomsTotal += "+" + widget.model.houseInfo.BedRoomsPossible.toString();
   String KitchenTotal = widget.model.houseInfo.Kitchens.toString();
   if(widget.model.houseInfo.KitchensPossible>0)
     KitchenTotal += "+" + widget.model.houseInfo.KitchensPossible.toString();
   String BathRoomTotal = widget.model.houseInfo.BathRooms.toString();
   if(widget.model.houseInfo.BathRoomsPossible>0)
     BathRoomTotal += "+" + widget.model.houseInfo.BathRoomsPossible.toString();
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          _buildCell("MLS@ Number:", widget.model.houseInfo.MLSNumber),
          _buildCell("Bed Room(s):", bedRoomsTotal),
          _buildCell("Kitchen:", KitchenTotal),
          _buildCell("BathRooms:", BathRoomTotal),
          _buildCell("Building Type:", widget.model.houseInfo.BuildingType),
          _buildCell("Property Type:", widget.model.houseInfo.PropertyType),
          _buildCell("Land Size:", widget.model.houseInfo.LandSizeTotal),
          _buildCell("Square Feet:", widget.model.houseInfo.SquareFeetText),
          _buildCell("Parking:", widget.model.houseInfo.ParkingType+"("+widget.model.houseInfo.ParkingSpaceTotal.toString()+")"),
          _buildCell("Possession Date:", widget.model.houseInfo.PossessionDate),
          _buildCell("Property Taxes / Year:", widget.model.houseInfo.Taxes.toString()+" / "+widget.model.houseInfo.TaxesYear),

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