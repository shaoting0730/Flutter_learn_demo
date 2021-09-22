import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'base_page.dart';
import 'appointment_history_page.dart';
import 'appointment_application_list_page.dart';
import '../models/ui/plan_model.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/contact_card.dart';
import '../widgets/plan_time_header.dart';
import '../widgets/house_card.dart';
import './booking_detail_page.dart';
import './open_locker_page.dart';
import './appointment_calendar_page.dart';
import '../service/serviceapi.dart';
import './automatic_audit_time.dart';
import './outline_detailed_room_page.dart';
import '../widgets/transparent_route.dart';
import '../service/baseapi.dart';
import '../pages/my_plans_page.dart';
import '../models/loginmodel.dart';
import '../widgets/phone_field.dart';
import './apply_locker_page.dart';
import '../models/houseproduct.dart';

class AppointmentDetailsPage extends BasePage {

  final PlanModel planModel;
  bool NeedRefreshHouseInfo;
  AppointmentDetailsPage({this.planModel, this.NeedRefreshHouseInfo=false});

  @override
  State<AppointmentDetailsPage> createState() {
    return _AppointmentDetailPageState();
  }
}

class _AppointmentDetailPageState extends BasePageState<AppointmentDetailsPage> {

  List<Widget> panelList = <Widget>[];
  List<Widget> appointActions = <Widget>[];
  List<Widget> actionButtons = <Widget>[];
  String strStatus = "";
  String strNextAction = "";
  bool _isNewBook = false;
  @override
  void initState() {
    super.initState();
    _isNewBook = false;
    title = "Appointment Details";
    refreshHouseInfo();
  }

  void refreshHouseInfo() async{
    displayProgressIndicator(true);
    if(widget.NeedRefreshHouseInfo)
    {
      var searchRequest = IOTDeviceHouseSearch(SearchType: 0, centerlongitude:0, centerlatitude:0, PageIndex: 0, PageSize: 50);
      searchRequest.SearchCriteria = RealtorOpenAPISearchModel(ReferenceNumber:widget.planModel.house.houseInfo.MLSNumber);
      var showingSchedule = await UserServerApi().SearchIoTDeviceHouse(context,searchRequest );
      if(showingSchedule!=null)
      {
        if(showingSchedule.ListObjects.length>0)
        {
          setState(() {
            widget.planModel.house = IOTDeviceHouseInfoModelToHouseModel(showingSchedule.ListObjects[0]);
          });
        }
      }
    }
    displayProgressIndicator(false);
  }
  
  @override
  Widget pageContent(BuildContext context) {
    panelList.clear();
    appointActions.clear();
    actionButtons.clear();
    strStatus = "";
    strNextAction = "";

    panelList.add(_buildHouseBookingCard());

    switch (widget.planModel.status) {
      case PlanStatus.confirmed:
        strStatus = "Showing Confirmed";
        strNextAction = "No further action needed!";
        actionButtons.add(
          _buildActionButton("New Booking", false),
        );
        actionButtons.add(
          _buildActionButton("Unlock", true),
        );

        ///Cancel
        appointActions.add(InkWell(
          onTap: () {
            _onTapCancel(context);
          },
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_details_cancel.png'),
                  SizedBox(width: 10,),
                  Text('Cancel Appointments', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                ],
              )
          ),
        ));
        ///Seperator
        appointActions.add(Divider(
          height: 2, color: Color(0xFFCCCCCC),
        ));
        ///ChangeTime
        appointActions.add(GestureDetector(
            onTap: () {
              _isNewBook = false;
              _onTapChangeTime(context);
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_propose.png'),
                    SizedBox(width: 10,),
                    Text('Propose New Time', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                )
            )
        ));
        panelList.add(_buildAppointmentStatus());
        panelList.add(_buildAppointmentActions(context));
        break;
      case PlanStatus.timechanged:
        strStatus = "Showing Time Changed";
        if(!widget.planModel.isMyHouse)
        {
          strNextAction = "You could 'Accept' or 'Propose New Time'!";
          actionButtons.add(
            _buildActionButton("Accept", true),
          );
        }
        ///Cancel
        appointActions.add(InkWell(
          onTap: () {
            _onTapCancel(context);
          },
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_details_cancel.png'),
                  SizedBox(width: 10,),
                  Text('Cancel Appointments', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                ],
              )
          ),
        ));
        ///Seperator
        appointActions.add(Divider(
          height: 2, color: Color(0xFFCCCCCC),
        ));
        ///ChangeTime
        appointActions.add(GestureDetector(
            onTap: () {
              _isNewBook = false;
              _onTapChangeTime(context);
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_propose.png'),
                    SizedBox(width: 10,),
                    Text('Propose New Time', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                )
            )
        ));
        panelList.add(_buildAppointmentStatus());
        panelList.add(_buildAppointmentActions(context));
        break;
      case PlanStatus.cancelled:
        actionButtons.add(
          _buildActionButton("New Booking", true),
        );
        break;
      case PlanStatus.decline:
        strStatus = "Showing has been rejected";
        strNextAction = "Please choose different time to resubmit!";
        ///ChangeTime
        appointActions.add(GestureDetector(
            onTap: () {
              _isNewBook = false;
              _onTapChangeTime(context);
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_propose.png'),
                    SizedBox(width: 10,),
                    Text('Propose New Time', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                )
            )
        ));
        panelList.add(_buildAppointmentStatus());
        panelList.add(_buildAppointmentActions(context));
        break;
      case PlanStatus.waiting:
        strStatus = "Waiting for owner to approve time";
        strNextAction = "";
        actionButtons.add(
          _buildActionButton("New Booking", true),
        );

        ///Cancel
        appointActions.add(InkWell(
          onTap: () {
            _onTapCancel(context);
          },
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_details_cancel.png'),
                  SizedBox(width: 10,),
                  Text('Cancel Appointments', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                ],
              )
          ),
        ));
        ///Seperator
        appointActions.add(Divider(
          height: 2, color: Color(0xFFCCCCCC),
        ));
        ///ChangeTime
        appointActions.add(GestureDetector(
            onTap: () {
              _isNewBook = false;
              _onTapChangeTime(context);
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_propose.png'),
                    SizedBox(width: 10,),
                    Text('Propose New Time', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                )
            )
        ));
        panelList.add(_buildAppointmentStatus());
        panelList.add(_buildAppointmentActions(context));
        break;
      case PlanStatus.none:
        if(widget.planModel.isMyHouse == true) {
          if(widget.planModel.house.deviceInfo!=null && widget.planModel.house.deviceInfo.DeviceMACAddress=="999999999")
            panelList.add(_buildApplyLocker(context));
          else
            actionButtons.add(
              _buildActionButton("Unlock", true),
            );
          panelList.add(_buildAutomaticAuditTime());
        } else {
          if(isAgent)
          {
            actionButtons.add(
              _buildActionButton("Booking", true),
            );
            if(widget.planModel.house.deviceInfo!=null && widget.planModel.house.deviceInfo.DeviceMACAddress=="")
            {
                panelList.add(_buildApplyLocker(context));
            }
          }
        }
        break;
      default:
    }
    panelList.add(_buildHouseDetail());
    if(widget.planModel.isMyHouse && widget.planModel.house.showingRequestModels!=null && widget.planModel.house.showingRequestModels.length > 0) {
      panelList.add(_buildAppointmentHistory());
    }
    else
      panelList.add(_buildMyAppointmentHistory(context));
    if(widget.planModel.house.houseInfo.NeighborHoods!="")
      panelList.add(_buildNeighborHoods());
    if(widget.planModel.house.houseInfo.CrossStreet!="")
      panelList.add(_buildCrossStreet());
    panelList.add(_buildListingContcts());

    // HouseOwner
    if(widget.planModel.isMyHouse) {
      panelList.add(_buildHouseOwner(context));
    }

    panelList.add(_buildNotesFromShowingAgent());
    
    panelList.add(SizedBox(height: 60,));
    return Container(
      color: Color(0xFFFAFAFA),   
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: panelList,
        )
      ),
    );
  }

  // House Owner
  Widget _buildApplyLocker(BuildContext context) {
    Widget action = InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForLockerPage(mlsNumber: widget.planModel.house.houseInfo.MLSNumber,)));
        },
        child: Container(
          decoration: shadowDecoration(),
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/icon_houseowner_add.png'),
                  SizedBox(width: 10,),
                  Expanded(
                      child: Text('I am this property listing Agent', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
                  ),
                ],
              )
          ),
        )
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Apply lockbox"),
          SizedBox(height: 10,),
          Container(
              decoration: shadowDecoration(),
              child: action
          )
        ],
      ),
    );
  }

  // House Owner
  Widget _buildHouseOwner(BuildContext context) {
    Widget displayCell = widget.planModel.house.houseOwner == null ? _buildHouseOwnerAdd(context) : _buildHouseOwnerInfo(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('House Owner'),
          SizedBox(height: 10,),
          displayCell
        ],
      ),
    );
  }

  Widget _buildHouseOwnerInfo(BuildContext context) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: ContactCard(avatar:'',username: widget.planModel.house.houseOwner.FirstName + " " + widget.planModel.house.houseOwner.LastName ,title:widget.planModel.house.houseOwner.PhoneNumber,content:widget.planModel.house.houseOwner.Email,contact:""),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
	            _removeFrontDeskAssistant(context, widget.planModel.house.houseOwner);
            },
          ),
        ],
      );
  }
  

  void _removeFrontDeskAssistant(BuildContext context, ImpersonationorInfoModel model) async {
    displayProgressIndicator(true);
    var request = ImpersonationModel(Guid: model.Guid);
    await UserServerApi().RemoveImpersonation(context, request);
    setState(() {
      widget.planModel.house.houseOwner = null;  
    });
    displayProgressIndicator(false);
  }


  Widget _buildHouseOwnerAdd(BuildContext context) {
    return InkWell(
      onTap: () {
        _showAddFrontDeskAssistantDialog(context);
      },
      child: Container(
        decoration: shadowDecoration(),
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: <Widget>[
              Image.asset('assets/icon_houseowner_add.png'),
              SizedBox(width: 10,),
              Expanded(
                child: Text('Add Houseowner', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
              ),
            ],
          )
        ),
      )
    );
  }

  void _showAddFrontDeskAssistantDialog(BuildContext context) {
    final _phoneNumberKey = GlobalKey<PhoneNumberFieldState>();

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext dcontext) {
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
                        Navigator.of(context).pop();
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
                        _addFrontDeskAssistant(phoneNumber);

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
            ),
          )
        );
      },
    );
  }

  void _addFrontDeskAssistant(String phoneNumber) async {
    displayProgressIndicator(true);
    var request = ImpersonationModel(
      ImpersonatorStoreCustomerGuid: phoneNumber, 
      ImpersonateeStoreCustomerGuid: loginResponse.StoreCustomerGuid,
      ProductGuid: widget.planModel.house.houseInfo.HouseGuid,
      CustomerRoleSystemName: "HouseOwner"
    );
    var response = await UserServerApi().AssignImpersonation(context, request);
    var showingRequestScheduler = await UserServerApi().LoadMyImpersonators(context);
    displayProgressIndicator(false);
    if(response && showingRequestScheduler != null) {
      showToastMessage(context, "Add success!");

      widget.planModel.house.houseOwner = ImpersonationorInfoModel(PhoneNumber: phoneNumber); 

      showingRequestScheduler.forEach((element) {
        if(element.ProductGuid == widget.planModel.house.houseInfo.HouseGuid) {

          setState(() {
            widget.planModel.house.houseOwner = element;
          });
        }
      });
    } 
  }
  

  // House Detail
  Widget _buildHouseDetail() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('House Details'),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.push(context, TransparentRoute(builder: (BuildContext context) => OutlineDetailedRoomPage(model: widget.planModel.house)));
            },
            child: Container(
              decoration: shadowDecoration(),
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_house_detail.png'),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text('Outline Detailed Room', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
                    ),
                    Image.asset('assets/ic_keyboard_arrow_right.png')
                  ],
                )
              ),
            )
          )
        ],
      ),
    );
  }
  // Automaticv audit time
  Widget _buildAutomaticAuditTime() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Showing Auto Confirm Setting'),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AutomaticAuditTimePage(model: widget.planModel)));
            },
            child: Container(
              decoration: shadowDecoration(),
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_propose.png'),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text('Auto Approve Schedule', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
                    ),
                    Image.asset('assets/ic_keyboard_arrow_right.png')
                  ],
                )
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildHouseBookingCard() {
    if(widget.planModel.status != PlanStatus.none) {
      return Column(
        children: <Widget>[
          PlanTimeHeader(model: widget.planModel, roundCorner: false),
          _buildHouseCard(),
        ],
      );
    } else {
      return Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFF536282),
              height: 120,
              width: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: _buildHouseCard(),  
            )
          ],
        )
      );
    }
  }

  Widget _buildHouseCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: double.infinity,
      decoration: shadowDecoration(),
      child: HouseCard(model: widget.planModel.house, actionButtons: actionButtons,)
    );
  }
  Widget _buildNeighborHoods() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Community Name'),
          SizedBox(height: 10,),
          Container(
              decoration: shadowDecoration(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                width: double.infinity,
                decoration: shadowDecoration(),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_location.png'),
                    SizedBox(width: 10,),
                    Text(widget.planModel.house.houseInfo.NeighborHoods, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildCrossStreet() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Cross Street'),
          SizedBox(height: 10,),
          Container(
              decoration: shadowDecoration(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                width: double.infinity,
                decoration: shadowDecoration(),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_location.png'),
                    SizedBox(width: 10,),
                    Text(widget.planModel.house.houseInfo.CrossStreet, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, bool fill) {
    Color color = fill ? Colors.red: Colors.white;
    Color textColor = fill ? Colors.white:Colors.red;
    return SizedBox(
      width: 150,
      child: RaisedButton(
        child: Text(text),
        onPressed: () {
          if(text == "Booking") {
            if(widget.planModel.house.deviceInfo==null || widget.planModel.house.deviceInfo.DeviceMACAddress==null || widget.planModel.house.deviceInfo.DeviceMACAddress=="")
              showErrorMessage(context, "Sorry, this house is not available for booking since this listing agent is not in our system, please contact the listing agent directly!");
            else
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailPage(houseModel: widget.planModel.house,IsNewBook: false, onBookingDetailPageSuccessCallback: () {
                setState(() {
                  this.widget.NeedRefreshHouseInfo = true;
                  this.refreshHouseInfo();
                });
              },)));
          } else if(text == "Unlock") {
            bool bTimeToUnlock = false;
            setState(() {
              this.widget.NeedRefreshHouseInfo = true;
              this.refreshHouseInfo();
            });
            if(widget.planModel.house.deviceToken!=null)
            {
              if(widget.planModel.house.deviceToken.Password!='')
                bTimeToUnlock = true;
            }
            if(bTimeToUnlock)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OpenLockerPage( planModel: widget.planModel)));
            }
            else
            {
              var format = new DateFormat('E d/MM/y', 'en');
              var hourFormatter = DateFormat('HH:mm', 'en');
              var date = format.format(TicksToDateTime(widget.planModel.ShowingRequest.ScheduledStartTime));
              var startAt = hourFormatter.format(TicksToDateTime(widget.planModel.ShowingRequest.ScheduledStartTime));
              var endAt = hourFormatter.format(TicksToDateTime(widget.planModel.ShowingRequest.ScheduledEndTime));
              var startOpenAt = hourFormatter.format(TicksToDateTime(widget.planModel.ShowingRequest.ScheduledStartTime).add(new Duration(minutes: -30)));
              var endOpenAt = hourFormatter.format(TicksToDateTime(widget.planModel.ShowingRequest.ScheduledEndTime).add(new Duration(minutes: 30)));
              
              _showWarningDialog(date, startAt, endAt, startOpenAt, endOpenAt);
            }
          }
          else if(text == "Accept") {
            _onTapAccept(context);
          } else if(text == "New Booking") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailPage(houseModel: widget.planModel.house,IsNewBook: true,onBookingDetailPageSuccessCallback: () {
                setState(() {
                  this.widget.NeedRefreshHouseInfo = true;
                  this.refreshHouseInfo();
                });
                },)));
          }
        },
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.red,)
        )
      ),
    );
  }


  void _showWarningDialog(String date, String startAt, String endAt, String startOpenAt, String endOpenAt) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            height: 175,
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text('Your booking time is '+date+' from '+startAt+' to '+endAt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      SizedBox(height: 10,),
                      Text('You only can unlock it from '+startOpenAt+' to '+endOpenAt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    ]
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: Container(
                        height: 50,
                        width: 320,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFDDDDDD),
                              width: 1.0,
                            ),
                          )
                        ),
                        alignment: AlignmentDirectional.center,
                          child: Text("Ok"),
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

  // Listing Contacts
  Widget _buildListingContcts() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('List Brokerage'),
          SizedBox(height: 10,),
          Container(
            decoration: shadowDecoration(),
            child: ContactCard(avatar:'',username:'',title:'',content:widget.planModel.house.houseInfo.ListingBroker,contact:"")
          )
        ],
      ),
    );
  }

  // Notes From Showing Agent
  Widget _buildNotesFromShowingAgent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Notes From Listing Agent'),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            width: double.infinity,
            decoration: shadowDecoration(),
            child: Text(widget.planModel.house.houseInfo.PublicRemarks, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
          )
        ],
      ),
    );
  }

  // Appointment Actions， 
  Widget _buildAppointmentActions(BuildContext context) {

    Widget displayContent;
    displayContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: appointActions,
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Appointment Actions"),
          SizedBox(height: 10,),
          Container(
            decoration: shadowDecoration(),
            child: displayContent
          )
        ],
      ),
    );
  }

  Widget _buildAppointmentStatus() {
    var list = List<Widget>();
    if(strStatus != "") {
      list.add(Text(strStatus, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A))));
    }
    if(list.length > 0) {
      list.add(SizedBox(height: 2,));
    }
    if(strNextAction != "") {
      list.add(Text(strNextAction, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)); 
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Appointment Status"),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            decoration: shadowDecoration(),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            ),
          )
        ],
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Container(
      child: Text(title, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),),
    );
  }

  void _onTapAccept(BuildContext context) async {

    displayProgressIndicator(true);
    widget.planModel.ShowingRequest.RequestStatus = 1;
    var response  = await UserServerApi().UpdateShowingSchedule(context, [widget.planModel.ShowingRequest]);
    displayProgressIndicator(false);
    if(response) {
      showToastMessage(context, "Success");
      Future.delayed(Duration(seconds:1), () {
        Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => MyPlansPage(pageIndex:0)));
      });
    }
  }

  void _onTapCancel(BuildContext context) async {

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning"),
          content: new Text("Are you sure to cancel the schedule?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                displayProgressIndicator(true);
                widget.planModel.ShowingRequest.RequestStatus = 4;
                var response  = await UserServerApi().UpdateShowingSchedule(context, [widget.planModel.ShowingRequest]);
                displayProgressIndicator(false);
                if(response) {
                  showToastMessage(context, "Success to cancel");
                  Future.delayed(Duration(seconds:1), () {

                    Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => MyPlansPage(pageIndex:0)));
                  });
                }
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );

    
  }
  void _onTapChangeTime(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context1) => AppointmentCalendarPage(
      initDateTime: TicksToDateTime(widget.planModel.ShowingRequest.ScheduledStartTime),
      houseModel: widget.planModel.house,
      IsNewBook: this._isNewBook,
      onPickedTime: (startAt, endAt) async {
        displayProgressIndicator(true);
        widget.planModel.ShowingRequest.RequestStatus = 0;
        widget.planModel.ShowingRequest.ScheduledStartTime = DateTimeToTicks(startAt);
        widget.planModel.ShowingRequest.ScheduledEndTime = DateTimeToTicks(endAt);
        var response  = await UserServerApi().UpdateShowingSchedule(context, [widget.planModel.ShowingRequest]);
        displayProgressIndicator(false);
        if(response) {
          showToastMessage(context, "Success");
          Future.delayed(Duration(seconds:1), () {

             Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => MyPlansPage(pageIndex:0)));
            // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          });
        }
      },)));
  }
  Widget _buildMyAppointmentHistory(BuildContext context) {
    String strTitle = 'You scheduled '+widget.planModel.house.houseInfo.TotalMyBookedShowing.toString()+' appointment(s)';
    if(widget.planModel.house.houseInfo.TotalMyBookedShowing==0)
      strTitle = 'No appointment';
    List<Widget> childrenList = List<Widget>();
    childrenList.add(Container(
        height: 18,
        width: 18,
        alignment: AlignmentDirectional.center,
        child: Image.asset('assets/icon_applications.png')
    ));
    childrenList.add(SizedBox(width: 10,));
    childrenList.add(Expanded(
        child: Text(strTitle, style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
    ));
    if(widget.planModel.house.houseInfo.TotalMyBookedShowing>0)
      childrenList.add(Image.asset('assets/ic_keyboard_arrow_right.png'));
    Widget displayContent;
    // 多条申请
    displayContent = InkWell(
        onTap: () {
          if(widget.planModel.house.houseInfo.TotalMyBookedShowing>0)
            Navigator.push(context, MaterialPageRoute(builder: (context1) => AppointmentApplicationListPage(HouseGuid:widget.planModel.house.houseInfo.HouseGuid, AddressText:widget.planModel.house.houseInfo.Address)));
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: childrenList,
            )
        )
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Appointment History"),
          SizedBox(height: 10,),
          Container(
              decoration: shadowDecoration(),
              child: displayContent
          )
        ],
      ),
    );
  }

  Widget _buildAppointmentHistory() {

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Appointment History'),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              Navigator.push(context,  MaterialPageRoute(builder: (context) => AppointmentHistoryPage(models: widget.planModel.house.showingRequestModels)));
            },
            child: Container(
              decoration: shadowDecoration(),
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                    children: <Widget>[
                      Container(
                          height: 18,
                          width: 18,
                          alignment: AlignmentDirectional.center,
                          child: Image.asset('assets/icon_applications.png')
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                          child: Text('Appointments history for this property', style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)))
                      ),
                      Image.asset('assets/ic_keyboard_arrow_right.png')
                    ],
                )
              ),
            )
          )
        ],
      ),
    );
  }

  ////Not Used

  // Calendar Sync
  Widget _buildCalendarSync() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Calendar Sync'),
          SizedBox(height: 10,),
          Container(
              decoration: shadowDecoration(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                width: double.infinity,
                decoration: shadowDecoration(),
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/icon_details_add.png'),
                    SizedBox(width: 10,),
                    Text("Add to My Calendar", style: TextStyle(fontSize: 14, color: Color(0xFF3A3A3A)),)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}