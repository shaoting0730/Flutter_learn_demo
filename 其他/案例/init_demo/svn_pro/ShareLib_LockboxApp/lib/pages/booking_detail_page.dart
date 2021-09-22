import 'package:flutter/material.dart';
import '../models/houseproduct.dart';
import 'base_page.dart';
import '../service/serviceapi.dart';
import '../models/showing.dart';
import '../models/ui/plan_model.dart';
import '../widgets/time_picker.dart';
import './booking_succes_page.dart';
import '../widgets/phone_field.dart';
import '../widgets/email_field.dart';
import '../widgets/select_customer_field.dart';
import '../service/scheduled_service.dart';


typedef BookingDetailPageSuccesCallback = void Function();

class BookingDetailPage extends BasePage {

  HouseModel houseModel;
  final bool IsNewBook;

  final BookingDetailPageSuccesCallback onBookingDetailPageSuccessCallback;

  BookingDetailPage({this.houseModel, this.IsNewBook=false, this.onBookingDetailPageSuccessCallback});

  @override
  State<BookingDetailPage> createState() {
    return BookingDetailPageState();
  }

}

class BookingDetailPageState extends BasePageState<BookingDetailPage> {

  final _customerNameKey = GlobalKey<SelectCustomerFieldState>();
  final _selectTimeKey = GlobalKey<TimePickerFieldState>();
  final _phoneKey = GlobalKey<PhoneNumberFieldState>();
  final _emailKey = GlobalKey<EmailFieldState>();
  
  var _customGuid = "";
  @override
  void initState() {
    super.initState();
    title = "Booking Detail";
  }

  @override
  Widget pageContent(BuildContext context) {
    
    return SingleChildScrollView(
      child:Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            _buildCustomer(),
            _buildPhone(),
            _buildEmail(),
            _buildSelectDate(),
            
            SizedBox(height: 15,),
            /*
            Container(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    onChanged: (bool value) {},
                    value: false, 
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                  Text('Remind me two hours in advance.')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    onChanged: (bool value) {},
                    value: false, 
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Text('Remind me two hours in advance.')
                ],
              ),
            ),
            */
            Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              width: 200,
              child: RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _onTapSubmit(context);
                },
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.red,)
                )
              ),
            )

          ],
        )
      )
    );
  }

  Widget _buildEmail() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          EmailField(key: _emailKey,)
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Phone', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          PhoneNumberField(key: _phoneKey, displayContryCode: true,)
        ],
      ),
    );
  }

  Widget _buildCustomer() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Customer', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          SelectCustomerField(
            key: _customerNameKey, 
            model: gShowingProfiles, 
            onSelectCustomer: (ShowingProfileModel model){
              _phoneKey.currentState.setPhoneNumber(model.PhoneNumber);
              _emailKey.currentState.setEmail( model.Email);
              _customGuid = model.Guid;
            },
            onEditingCustomName: () {
              // 如果名字被编辑了，那么这个会是一个新的用户
              _customGuid = "";
            },
          )
        ],
      ),
    );
  }
  
  Widget _buildSelectDate() {
    return Container(  
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Select Time', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 7,),
          TimePickerField(key: _selectTimeKey, houseModel: widget.houseModel, IsNewBook: widget.IsNewBook,)
        ],
      ),
    );
  }

  void _onTapSubmit(BuildContext context) async {

    if(_customerNameKey.currentState.text == null || _customerNameKey.currentState.text == "") {
      showErrorMessage(context, "Please fill the customer name");
      return;
    }

    if(_selectTimeKey.currentState.startAt == null || _selectTimeKey.currentState.endAt == null) {
      showErrorMessage(context, "Please choose your time");
      return;
    }
    displayProgressIndicator(true);

    var showingRequestModel = ShowingRequestModel(
      ProductGuid: widget.houseModel.houseInfo.HouseGuid, 
      MLSNumber: widget.houseModel.houseInfo.MLSNumber, 
      RequestStatus: 0,
      ScheduledStartTime: DateTimeToTicks(_selectTimeKey.currentState.startAt), 
      ScheduledEndTime: DateTimeToTicks(_selectTimeKey.currentState.endAt));

    var requestModel = ShowingProfileModel(
                        Guid: _customGuid,
                        CustomerName: _customerNameKey.currentState.text, 
                        ProfileName: _customerNameKey.currentState.text, 
                        PhoneNumber: _phoneKey.currentState.phoneNumber(),
                        Email: _emailKey.currentState.email,
                        ShowingDetails: [showingRequestModel]
                      );
    
    var response = await UserServerApi().CreateUpdateProfile(context, requestModel);
    

    if(response) {
      var searchRequest = IOTDeviceHouseSearch(SearchType: 0, centerlongitude:0, centerlatitude:0, PageIndex: 0, PageSize: 50);
      searchRequest.SearchCriteria = RealtorOpenAPISearchModel(ReferenceNumber:widget.houseModel.houseInfo.MLSNumber);
      var showingSchedule = await UserServerApi().SearchIoTDeviceHouse(context,searchRequest );
      if(showingSchedule!=null)
      {
        if(showingSchedule.ListObjects.length>0 && mounted)
        {
          setState(() {
            widget.houseModel = IOTDeviceHouseInfoModelToHouseModel(showingSchedule.ListObjects[0]);
          });
        }
      }
    }

    if(widget.onBookingDetailPageSuccessCallback != null) {
      widget.onBookingDetailPageSuccessCallback();
    }
    displayProgressIndicator(false);
    await Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSuccessPage(success: response,)));
    _selectTimeKey.currentState.startAt = null;
    _selectTimeKey.currentState.endAt = null;
    _selectTimeKey.currentState.clear();
  }
}