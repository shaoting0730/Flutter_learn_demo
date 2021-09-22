import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/houseproduct.dart';
import '../service/baseapi.dart';
import '../service/serviceapi.dart';
import '../pages/base_page.dart';
import '../pages/signup_real_estate_agent_step2_page.dart';
import '../pages/signup_page.dart';
import '../pages/signup_real_estate_agent_success_page.dart';
import '../widgets/text_field.dart';
import '../widgets/step.dart';
import '../widgets/find_my_office.dart';
import '../widgets/dropdown_select_field.dart';
import '../models/loginmodel.dart';


class SignupRealEstateAgentPage extends BasePage {

  final bool registerOnly;
  SignupRealEstateAgentPage({this.registerOnly = false});

  @override
  State<StatefulWidget> createState() {
    return SignupRealEstateAgentPageState();
  }

}

class SignupRealEstateAgentPageState extends BasePageState<SignupRealEstateAgentPage> {
  final _findMyOfficeKey =GlobalKey<FindMyOfficeFieldState>();
  final _loginIdKey = GlobalKey<TextInputFieldState>();
  final _firstNameKey = GlobalKey<TextInputFieldState>();
  final _lastNameKey = GlobalKey<TextInputFieldState>();

  bool isChecked = false;
  bool _displayDetail = false;
  MLSAgentOfficeModel _currentSelectModel ;
  List<MLSAgentOfficeModel> models = List<MLSAgentOfficeModel>();

  @override
  void initState() {
    super.initState();
    hiddenAppBar = true;
  }
  
  @override
  Widget pageContent(BuildContext context) {

    var list = List<Widget>();
    list.add(_buildHeader());
    if(widget.registerOnly == false) {
      list.add(_buildStepHead());
    } else {
      list.add(SizedBox(height: 40,));
    }
    
    list.add(_buildYourOffice(context));
    if(_displayDetail) { 
      list.add(_buildOfficeAddress());
      list.add(_buildMLSLoginID());
      if(widget.registerOnly) {
        list.add(_buildUsername());
      }
      list.add(SizedBox(height: 40,));
      list.add(_buildNextButton(context));
    }
    else
    {
      list.add(_buildImPersonal(context));
    }

    return Stack(
      children: <Widget>[    
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list
            ),
          )
        ),
        Positioned(
          left: 10,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 30,
                child: Image.asset('assets/ic_back.png'),
              ),
            )
          )
        )
      ],
    );
  }

  Widget _buildImPersonal(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text( "Individual Register Click Here>", style: TextStyle(fontSize: 14, color: Color(0xFF536282))),
          )
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(  
              margin: const EdgeInsets.fromLTRB(15, 0, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('First Name', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
                  SizedBox(height: 7,),
                  TextInputField(key: _firstNameKey, text:loginResponse.FirstName)
                ],
              ),
            ),
            flex: 1
          ),
          Expanded(
            child: Container(  
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Last Name', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
                  SizedBox(height: 7,),
                  TextInputField(key: _lastNameKey, text:loginResponse.LastName)
                ],
              ),
            ),
            flex: 1,
          ),
        ]
      ),
    );
  }

  Widget _buildOfficeAddress() {
    List<String> options = List<String>();
    models.forEach((element) {
      options.add(element.OfficeAddress);
    });
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Office Address', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          DropDownSelectField(placeholder: "", options: options, onDropDownSelected: (String option) {
            models.forEach((element) {
              if(option == element.OfficeAddress) {
                setState(() {
                  _currentSelectModel = element;
                });
              }
            });
          },)
        ],
      ),
    );
  }

  Widget _buildYourOffice(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Your Office Telephone', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          FindMyOfficeField(
            key: _findMyOfficeKey, 
            onFindMyOfficeTap: () {
              _trySearchOffice(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildMLSLoginID() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('MSLLoginID', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TextInputField(key: _loginIdKey)
        ],
      ),
    );
  }

  
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: Color(0xFF536282),
      alignment: AlignmentDirectional.bottomCenter,
      child: SafeArea(
        bottom: false,
        child: Text("Real Estate Sign Up", style: TextStyle(fontSize: 24, color: Colors.white),)
      )
    );
  }

  Widget _buildStepHead() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      alignment: AlignmentDirectional.center,
      child: StepProgress(),
    );
  }


  Widget _buildNextButton(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment(0, 0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        onPressed: () {
          _onTapNext(context);
        },
        color: Color(0xFFFF3C38),
        child: Container(
          height: 44,
          width: 200,
          alignment: Alignment(0, 0),
          child: Text("Next", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
        )
      )
    );
  }

  void _trySearchOffice(BuildContext context) async {
    if(_findMyOfficeKey.currentState.officeCode == null || _findMyOfficeKey.currentState.officeCode == "") {
      showErrorMessage(context, "Please fill office Telephone");
      return;
    }
    displayProgressIndicator(true);
    var response = await UserServerApi().SearchValidMLSAgentOfficeByOfficePhone(context, _findMyOfficeKey.currentState.officeCode);
    displayProgressIndicator(false);  
    
    if(response == null) {
      return;
    } else if(response.length == 0) {
      showErrorMessage(context, "Not found office");
    } else {
      setState(() {
        _displayDetail = true;
        models = response;
      });
    }
    
  }

  void _onTapNext(BuildContext context) async {
    if(_loginIdKey.currentState.text == null || _loginIdKey.currentState.text == "") {
      showErrorMessage(context, "Please fill _loginKey");
      return;
    }

    if(widget.registerOnly == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRealEstateAgentStep2Page(model: _currentSelectModel, loginId: _loginIdKey.currentState.text)));
    } else {
      if(_firstNameKey.currentState.text == null || _firstNameKey.currentState.text == "") {
        showErrorMessage(context, "Please fill in First Name");
        return;
      }

      if(_lastNameKey.currentState.text == null || _lastNameKey.currentState.text == "") {
        showErrorMessage(context, "Please fill in Last Name");
        return;
      }

      displayProgressIndicator(true);
      var request = MLSMemberUpgrade(
        FirstName: _firstNameKey.currentState.text,
        LastName: _lastNameKey.currentState.text,
        MLSLoginID: _loginIdKey.currentState.text,
        MLSOfficeID: _currentSelectModel.OfficeID
      );

      var response = await UserServerApi().UpgradeAccountToMLSMember(context, request);
      displayProgressIndicator(false);
      if(response != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupRealEstateAgentSuccessPage()));
      } 
    }
  }
}