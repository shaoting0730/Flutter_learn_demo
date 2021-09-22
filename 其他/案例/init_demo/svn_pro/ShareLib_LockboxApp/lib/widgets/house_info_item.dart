import 'package:flutter/material.dart';
import '../models/houseproduct.dart';
import './house_avatar.dart';
import './right_corner_checkbox.dart';

class HouseInfoItemCell extends StatefulWidget {

  final IOTDeviceHouseInfoModel houseInfo;
  
  HouseInfoItemCell({this.houseInfo});

  @override
  State<HouseInfoItemCell> createState() {
    return HouseInfoItemCellState();
  }

}

class HouseInfoItemCellState extends State<HouseInfoItemCell> {

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: <Widget>[
          _buildHouseBasisInfo()
        ],
      ),
    );
  }

  Widget _buildHouseBasisInfo() {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFFF5F5F5),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              ////HouseAvatar(thumbnailUrl: widget.houseInfo.HouseInfo.Thumbnail,),
              HouseAvatar(thumbnailUrl: "https://i.pinimg.com/736x/c4/72/06/c472069bccf5658b275dcb1955824c9a--cute-little-houses-little-cottages.jpg",),
              SizedBox(width: 10,),
              _buildHouseTextInfoArea(),
              _buildHouseInfoRightArea(),
            ],
          ),
        ),
        _buildHouseInfoSelectArea()
      ]
    );
  }

  // House Info 右下角的可选件
  Widget _buildHouseInfoSelectArea() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: RightCornerCheckBox(),
    );
  }

  Widget _buildHouseInfoRightArea() {
    return Container(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset('assets/ic_keyboard_arrow_right.png'),
          )
        ],
      ),
    );
  }
  Widget _buildHouseTextInfoArea() {
    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(widget.houseInfo.HouseInfo.ListingPrice.toString(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282))),
            Text(widget.houseInfo.HouseInfo.Address, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xFFAAAAAA))),
            SizedBox(height: 4),
            Text("MSL@ Number: " + widget.houseInfo.HouseInfo.MLSNumber, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Color(0xFFAAAAAA))),
            SizedBox(height: 2),
            _buildHouseBadges()
          ],
        )
    );
  }


  Widget _buildHouseBadges() {
    String BedRoomsTotal = widget.houseInfo.HouseInfo.BedRooms.toString();
    if(widget.houseInfo.HouseInfo.BedRoomsPossible>0)
      BedRoomsTotal += "+"+widget.houseInfo.HouseInfo.BedRoomsPossible.toString();
    String BathRoomsTotal = widget.houseInfo.HouseInfo.BathRooms.toString();
    if(widget.houseInfo.HouseInfo.BathRoomsPossible>0)
      BathRoomsTotal += "+"+widget.houseInfo.HouseInfo.BathRoomsPossible.toString();
    return Row(
      children: <Widget>[
        _buildBadge(BedRoomsTotal, Image.asset('assets/ic_mini_bedroom.png')),
        _buildBadge(BathRoomsTotal, Image.asset('assets/ic_mini_bathroom.png')),
        _buildBadge(widget.houseInfo.HouseInfo.ParkingSpaceTotal.toInt().toString(), Image.asset('assets/ic_mini_singlefamily.png')),
      ],
    );
  }
  
  Widget _buildBadge(String number, Image badge){
    return Container(
      child: Row(
        children: <Widget>[
          Text(number, style: TextStyle(fontSize: 10, color: Color(0xFF6E7B96))),
          badge
        ],
      )
    );
  }
}