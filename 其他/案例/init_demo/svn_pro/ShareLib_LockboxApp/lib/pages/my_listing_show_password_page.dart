import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import '../widgets/house_card.dart';
import '../widgets/shadow_decoration.dart';
import 'base_page.dart';

class MyListShowPasswordPage extends BasePage {

  final HouseModel model;
  MyListShowPasswordPage({this.model});
  
  @override
  State<StatefulWidget> createState() {
    
    return MyListShowPasswordPageState();
  }

}

class MyListShowPasswordPageState extends BasePageState<MyListShowPasswordPage> {
  @override
  void initState() {
    super.initState();
    title = "Show Password";
  }

  @override
  Widget pageContent(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildHouseCard(),
          SizedBox(height: 20,),
          _buildLockerPassword()
        ],
      ),
    ); 
  }


  Widget _buildHouseCard() {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        width: double.infinity,
        decoration: shadowDecoration(),
        child: HouseCard(
          model:widget.model, 
          displayFavorite: false,
        )
    );
  }

  Widget _buildLockerPassword() {
    String strPassword = '';
    if(widget.model.deviceToken!=null)
    {
      strPassword = widget.model.deviceToken.Password;
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      height: 180,
      width: double.infinity,
      color: Color(0xFF536282),
      child: Container(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Unlock Password', style: TextStyle(fontSize: 14, color: Colors.white,)),
            Text(strPassword, style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        )
      ),
    );
  }
}