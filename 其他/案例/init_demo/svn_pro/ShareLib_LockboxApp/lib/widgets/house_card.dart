import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../service/baseapi.dart';
import './house_avatar.dart';
import '../models/ui/plan_model.dart';
import '../service/serviceapi.dart';
import '../pages/photo_view_page.dart';
import '../pages/newsletter_page.dart';
import '../pages/my_listing_show_password_page.dart';
import '../pages/apply_locker_page.dart';

typedef OnFavoritedClick =  void Function();

class HouseCard extends StatefulWidget {
  final HouseModel model;
  final int messageCount;
  final List<Widget> actionButtons;
  final bool displayFavorite;
  final bool isFavorite;
  final bool showMore;
  final OnFavoritedClick onFavoritedClick;
  final bool showQuestionnaire;
  HouseCard({this.model, this.messageCount = 0, this.actionButtons, this.displayFavorite = true, this.isFavorite = false, this.showMore = false, this.onFavoritedClick, this.showQuestionnaire = false});

  @override
  State<StatefulWidget> createState() {
    return HouseCardState();
  }
}

class HouseCardState extends State<HouseCard> {

  bool isFavorite = false;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(widget.isFavorite)
        isFavorite = widget.isFavorite;
      else
        isFavorite = widget.model.houseInfo.IsFavorite;
    });

    List<Widget> list = <Widget>[
      _buildHouseBasisInfo(context)
    ];

    if(widget.messageCount > 0) {
      list.insert(0, _buildMessageTip());
    }

    if(widget.showMore) {
      if(isExpanded ) {
        list.add(_buildMoreDownSection());
      } else {
        list.add(_buildMoreUpSection());
      }
    }

    if(widget.showQuestionnaire) {
      list.add(_buildQuestionnaire());
    }

    if(widget.actionButtons != null) {
      list.add(Container(
        width: double.infinity,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.actionButtons
        )
      ));
    }

    List<Widget> layers = <Widget>[
      Column(
        children: list
      ),      
    ];

    if(widget.displayFavorite) {
      layers.add(_buildFavorite(context));
    }

    return Container(
      child: Stack(
        children: layers
      )  
    );
  }

  Widget _buildQuestionnaire() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5)))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child:Text('You have an incomplete questionaire.', style: TextStyle(color: Color(0xFF6E7B96), fontWeight: FontWeight.w600, fontSize: 14),),
          ),
          
          Text('>', style: TextStyle(color: Color(0xFF6E7B96),fontWeight: FontWeight.bold, fontSize: 14),),
        ]
      ),
    );
  }

  Widget _buildMoreDownSection() {

    var list = List<Widget>();
    list.add(
      InkWell(
        child: Container(
          alignment: Alignment(0, 0),
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF536282) ),
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: 24,
          width: 155,
          child: Text("NewsLetter by Email", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
        ),
        onTap: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsLetterPage(byEmail: true,model: widget.model)));
        },
      ),
    );

    list.add(                
      InkWell(
        child: Container(
          alignment: Alignment(0, 0),
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF536282) ),
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: 24,
          width: 155,
          child: Text("NewsLetter by SMS", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
        ),
        onTap: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsLetterPage(byEmail: false,model: widget.model)));
        },
      )
    );

    list.add(
      InkWell(

        child: Container(
          alignment: Alignment(0, 0),
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF536282) ),
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          height: 24,
          width: 155,
          child: Text("Show Password", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
        ),
        onTap: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => MyListShowPasswordPage(model: widget.model,)));
        },
      ),
    );

    if(isAgent || isAgentAssistant) {
      list.add(
        InkWell(

          child: Container(
            alignment: Alignment(0, 0),
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF536282) ),
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            height: 24,
            width: 155,
            child: Text("Bind Lockbox", style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96)))
          ),
          onTap: () {
            Navigator.push(context,  MaterialPageRoute(builder: (context) => ApplyForLockerPage(mlsNumber: widget.model.houseInfo.MLSNumber, model: widget.model,)));
          },
        ),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
            alignment: AlignmentDirectional.center,
            child: Wrap(
              runSpacing: 10,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children:  list
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                isExpanded = false;
              });
            },
            child:Container(
              padding: const EdgeInsets.all(15),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE5E5E5)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Up', style: TextStyle(color: Color(0xFF6E7B96)),),
                  SizedBox(width: 10,),
                  Image.asset('assets/icon_double_up.png')
                ]
              ),
            )
          )
        ]
      )
    );
  }

  Widget _buildMoreUpSection() {
    return InkWell(
      onTap: (){
        setState(() {
          isExpanded = true;
        });
      },
      child:Container(
        padding: const EdgeInsets.all(15),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('More', style: TextStyle(color: Color(0xFF6E7B96)),),
            SizedBox(width: 10,),
            Image.asset('assets/icon_double_down.png')
          ]
        ),
      )
    );
  }

  Widget _buildMessageTip() {
    String text = "You have " + widget.messageCount.toString() + " messages to review" ;
    return Container(
      height: 24,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(15, 8, 40, 0),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFF8730)),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/icon_orange_warning.png'),
          SizedBox(width: 5,),
          Text(text, style: TextStyle(color: Color(0xFFFF8730), fontSize: 14),)
        ],
      ),
    );
  }

  Widget _buildHouseBasisInfo(BuildContext context) {
    String strHomeImage;
    if(widget.model.houseInfo!= null && widget.model.houseInfo.ImageURLs!=null)
    {
      if(widget.model.houseInfo.ImageURLs.length>0)
        strHomeImage = widget.model.houseInfo.ImageURLs[0];
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("[For "+ widget.model.houseInfo.SaleOrLease+"]", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282))),
              GestureDetector(
                onTap: () {
                  if(widget.model.houseInfo!= null && widget.model.houseInfo.ImageURLs.length > 0 ) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewPage(imageUrls: widget.model.houseInfo.ImageURLs)));
                  }
                },
                child: HouseAvatar(thumbnailUrl:  strHomeImage),
              )
              
            ]
          ),
          SizedBox(width: 10,),
          Expanded(
            child: _buildHouseTextInfoArea(),
          )
        ],
      ),
    );
  }

  Widget _buildHouseTextInfoArea() {
    final formatter = new NumberFormat("#,###");
    String strFullAddress = widget.model.houseInfo.Address;
    if(widget.model.houseInfo.Address=="")
      strFullAddress = "Address not available";
    if(widget.model.houseInfo.City!=null && widget.model.houseInfo.City!="")
      strFullAddress += ","+widget.model.houseInfo.City;
    if(widget.model.houseInfo.State!=null && widget.model.houseInfo.State!="")
      strFullAddress += ","+widget.model.houseInfo.State;
    if(widget.model.houseInfo.NeighborHoods!="")
      strFullAddress += ", "+widget.model.houseInfo.NeighborHoods;
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(strFullAddress, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282))),
            SizedBox(height: 10,),
            ///Text("[For "+ widget.model.houseInfo.SaleOrLease+"]", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282))),
            ///SizedBox(height: 10,),
            Text("MSL@ Number: " + widget.model.houseInfo.MLSNumber, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xFFAAAAAA))),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:Text("\$"+formatter.format(widget.model.houseInfo.ListingPrice), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF536282))),
                  ),
                  _buildHouseBadges()
                ],
              )
            ),
            ///SizedBox(height: 10,),
            ///Text(widget.model.houseInfo.ListingBroker, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xFFAAAAAA))),
          ],
        )
    );
  }

Widget _buildHouseBadges() {
  String BedRoomsTotal = widget.model.houseInfo.BedRooms.toString();
  if(widget.model.houseInfo.BedRoomsPossible>0)
    BedRoomsTotal += "+"+widget.model.houseInfo.BedRoomsPossible.toString();
  String BathRoomsTotal = widget.model.houseInfo.BathRooms.toString();
  if(widget.model.houseInfo.BathRoomsPossible>0)
    BathRoomsTotal += "+"+widget.model.houseInfo.BathRoomsPossible.toString();
    return Row(
      children: <Widget>[
        _buildBadge(BedRoomsTotal, Image.asset('assets/ic_mini_bedroom.png')),
        SizedBox(width: 2,),
        _buildBadge(BathRoomsTotal, Image.asset('assets/ic_mini_bathroom.png')),
        SizedBox(width: 2,),
        _buildBadge(widget.model.houseInfo.ParkingSpaceTotal.toInt().toString(), Image.asset('assets/ic_location_car.png')),
      ],
    );
  }
  
  Widget _buildBadge(String number, Image badge){
    return Container(
      child: Row(
        children: <Widget>[
          Text(number, style: TextStyle(fontSize: 14, color: Color(0xFF6E7B96))),
          badge
        ],
      )
    );
  }

  Widget _buildFavorite(BuildContext context) {
 
    var favoriteIcon =isFavorite ? Image.asset('assets/icon_favroite_selected.png'): Image.asset('assets/icon_favroite_unselected.png');
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          _onTapFavorite(context);
        },
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment(0, 0),
          child: favoriteIcon,
        )
      )
    );
  }

  void _onTapFavorite(BuildContext context) {
    
    if(isFavorite) {
      UserServerApi().RemoveProductFromWishList(context, [widget.model.houseInfo.HouseGuid]);
    } else {
      UserServerApi().AddProductToWishList(context, widget.model.houseInfo.HouseGuid);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.model.houseInfo.IsFavorite = isFavorite;

    if(widget.onFavoritedClick != null) {
      widget.onFavoritedClick();
    }
  }

}