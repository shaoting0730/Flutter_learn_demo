import 'package:flutter/material.dart';
import 'dart:async';
import 'base_page.dart';
import '../widgets/phone_field.dart';
import '../widgets/text_field.dart';
import '../service/serviceapi.dart';
import '../models/showing.dart';


class AddClientPage extends BasePage {

  final ShowingProfileModel model;
  final VoidCallback addSuccessCallback;
  AddClientPage({this.addSuccessCallback, this.model});

  @override
  State<AddClientPage> createState() {
    return AddClientPageState();
  }

}

class AddClientPageState extends BasePageState<AddClientPage> {

  var _customerKey = GlobalKey<TextInputFieldState>();
  var _mobileKey = GlobalKey<PhoneNumberFieldState>();
  var _emailKey = GlobalKey<TextInputFieldState>();

  @override
  void initState() {
    super.initState();

    title = "Customer detail";
  }
  
  @override
  Widget pageContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            _buildCustomerNumber(),
            _buildMobileNumber(),
            _buildEmailNumber(),
            SizedBox(height: 70,),
            _buildAddButton(context)
          ],
        )
      )
    );
  }

  Widget _buildCustomerNumber() {
    String customerName = widget.model != null ? widget.model.CustomerName: "";
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Customer', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _customerKey, text: customerName)
        ],
      ),
    );
  }

  Widget _buildMobileNumber() {
    String phoneNumber = widget.model != null ? widget.model.PhoneNumber : "";
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Mobile', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PhoneNumberField(displayContryCode: true, key: _mobileKey, phoneNumber: phoneNumber)
        ],
      ),
    );
  }

  Widget _buildEmailNumber() {
    String email = widget.model != null ? widget.model.Email : "";
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _emailKey, text: email,)
        ],
      ),
    );
  }


  Widget _buildAddButton(BuildContext context) {
    var buttonText = widget.model != null? "Submit" : "Add";
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child:  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        onPressed: () {
          _onTapAdd(context);
        },
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text(buttonText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  void _onTapAdd(BuildContext context) async {
    if(_customerKey.currentState.text == null || _customerKey.currentState.text == "") {
      showErrorMessage(context, "Please fill in Customer");
      return;
    }

    displayProgressIndicator(true);
    
    ShowingProfileModel request;
    if(widget.model != null) {
      request = widget.model;
      request.CustomerName = _customerKey.currentState.text;
      request.ProfileName = _customerKey.currentState.text;
      request.PhoneNumber = _mobileKey.currentState.phoneNumber();
      request.Email = _emailKey.currentState.text;
    } else {
      request =  ShowingProfileModel(CustomerName: _customerKey.currentState.text, ProfileName: _customerKey.currentState.text, PhoneNumber: _mobileKey.currentState.phoneNumber(), Email:_emailKey.currentState.text );
    }
    var response = await UserServerApi().CreateUpdateProfile(context, request);
    

    displayProgressIndicator(false);
    if(response) {
      showToastMessage(context, "Add profile success");
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pop(context,true);
        if(widget.addSuccessCallback != null) {
          widget.addSuccessCallback();
        }
      });
    } 
  }

}