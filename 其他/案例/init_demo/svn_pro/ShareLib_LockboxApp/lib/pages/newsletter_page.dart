import 'package:flutter/material.dart';
import '../service/serviceapi.dart';
import '../widgets/house_card.dart';
import 'base_page.dart';
import '../models/ui/plan_model.dart';
import '../models/showing.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/text_field.dart';
import '../pages/newsletter_send_success_page.dart';

class NewsLetterPage extends BasePage {

  final bool byEmail;
  final HouseModel model;
  NewsLetterPage({this.byEmail = false, this.model});

  @override
  State<StatefulWidget> createState() {
    return NewsLetterPageState();
  }

}

class NewsLetterPageState extends BasePageState<NewsLetterPage> {

  var _titleKey = GlobalKey<TextInputFieldState>();
  var _contentKey = GlobalKey<TextInputFieldState>();

  @override
  void initState() {
    super.initState();

    title = widget.byEmail ? "NewsLetter by Email" : "NewsLetter by SMS";
  }

  @override
  Widget pageContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: shadowDecoration(),
              child: HouseCard(model: widget.model, displayFavorite: false,)
            ),
            SizedBox(height: 20,),
            _buildContent(context)
          ],
        ),
      )
    );
  }

  Widget _buildContent(BuildContext context) {
    var list = List<Widget>();
    if(widget.byEmail) {
      list.add(_buildTitleNumber());
      
    } 
    list.add(_buildContentNumber());
    list.add(SizedBox(height: 20,));
    list.add(_buildSendButton(context));
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
      decoration: shadowDecoration(),
      child: Column(
        children: list
      ),
    );
  }

  Widget _buildTitleNumber() {
    
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Title', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _titleKey)
        ],
      ),
    );
  }

  Widget _buildContentNumber() {
    
    var text = "MLS@ Number:" + widget.model.houseInfo.MLSNumber + "\n" + "Adress:" + widget.model.houseInfo.Address;
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Content', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          Container(
            height: 200,
            child: TextInputField(key: _contentKey, maxLines: 10, text: text,)
          )
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      alignment: Alignment(0, 0),
      child:SizedBox(
        width: 200,
        height: 44,
        child: RaisedButton(
          child: Text("Send"),
          onPressed: () {
            _onTapSend(context);
          },
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.red,)
          )
        )
      )
    );
  }


  void _onTapSend(BuildContext context) async {
    displayProgressIndicator(true);
    var content = _contentKey.currentState.text != null? _contentKey.currentState.text: "";
    var title = "";
    if(widget.byEmail) {
      title = _titleKey.currentState.text != null? _titleKey.currentState.text: "";
    }
    var request = HouseNewsLetterRequest();
    request.MLSNumber = widget.model.houseInfo.MLSNumber;
    request.Title = title;
    request.Content = content;
    request.Method = widget.byEmail ? 1: 2;
    var result = await UserServerApi().SendHouseNewsLetter(context, request);
    displayProgressIndicator(false);

    if(result) {
      Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsLetterSuccessPage(byEmail: widget.byEmail,)));
    }
  }
}