import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import '../service/baseapi.dart';
import 'base_page.dart';
import '../service/serviceapi.dart';
import '../widgets/empty_state.dart';
import '../widgets/front_desk_assistant_cell.dart';
import '../widgets/phone_field.dart';
import '../models/loginmodel.dart';

class FrontDeskAssistantPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return FrontDeskAssistantPageState();
  }

}

class FrontDeskAssistantPageState extends BasePageState<FrontDeskAssistantPage>  {

  RefreshController _refreshController = RefreshController();

  List<ImpersonationorInfoModel> models = List<ImpersonationorInfoModel>();

  
  @override
  void initState() {
    super.initState();
    title = "Front desk assistant";
    
    _requestRefresh(true, false, );
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  void _requestRefresh(bool loading, bool readMore) async {
    
    displayProgressIndicator(true);
    // 查询
    var showingRequestScheduler = await UserServerApi().LoadMyImpersonators(context);
    
    displayProgressIndicator(false);
    if(mounted) {
      if(showingRequestScheduler == null) {
        return;
      }
      var frontdesk = List<ImpersonationorInfoModel>();
      showingRequestScheduler.forEach((item){
        if(item.CustomerRoleSystemName=="MLSAgentAssistant")
          frontdesk.add(item);
      });

      setState(() {  
        models = frontdesk;
      });
      if(!loading) {
        _refreshController.sendBack(!readMore,  RefreshStatus.completed);
      }
    }
  }

  void _onRefresh(bool up) async {
    _requestRefresh(false, !up);
  }

  @override
  Widget pageContent(BuildContext context) {

    if(models.length == 0)  {
      return EmptyRecord();
    }
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: models.length,
          itemBuilder: (BuildContext context, int index) {

            var object = models[index];
            return Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: FrontDeskAssistantCell(model: object),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        models.removeAt(index);
                      });
                      _removeFrontDeskAssistant(context, object);
                    },
                  ),
                ],
              )
            );
          },
        )
    );
  }

 @override
  List<Widget> getRightActions() {
    return <Widget>[
      IconButton(
        icon: ImageIcon(
          AssetImage('assets/ic_add.png'),
          color: Colors.black
        ),
        color: Colors.black,
        onPressed: () {
          _showAddFrontDeskAssistantDialog(scaffoldKey.currentContext);
        },
      ),
    ];
  }

  void _showAddFrontDeskAssistantDialog(BuildContext context) {
    final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          content: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Text('please fill in the front desk', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                Text('assistant\'s mobile phone number', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                PhoneNumberField(displayContryCode: true,key: _phoneNumberKey),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child:  Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide( 
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                          child: Text("Cancel"),
                        )
                    ),
                    InkWell(
                      onTap: (){
                        var phoneNumber = _phoneNumberKey.currentState.phoneNumber();
                        Navigator.of(context).pop();
                        if(phoneNumber == null || phoneNumber == "") {
                          showErrorMessage(context, "Please fill in the PhoneNumber");
                          return ;
                        }
                        _addFrontDeskAssistant(context, phoneNumber);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                        width: 140,
                        child: Text("Confirm"),
                      )
                    ),
                  ]
                )
              ]
            )
          )
        );
      },
    );
  }

  void _addFrontDeskAssistant(BuildContext context, String phoneNumber) async {
    displayProgressIndicator(true);
    var request = ImpersonationModel(
      ImpersonatorStoreCustomerGuid: phoneNumber, 
      ImpersonateeStoreCustomerGuid: loginResponse.StoreCustomerGuid,
      CustomerRoleSystemName: "MLSAgentAssistant"
      );
    var response = await UserServerApi().AssignImpersonation(context, request);
    displayProgressIndicator(false);
    if(response) {
      showToastMessage(context, "Add success!");
      _requestRefresh(true, false);
    }
    
  }

  void _removeFrontDeskAssistant(BuildContext context, ImpersonationorInfoModel model) async {
    var request = ImpersonationModel(Guid: model.Guid);
    await UserServerApi().RemoveImpersonation(context, request);
  }

}