import 'package:flutter/material.dart';
import 'base_page.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'appointment_details_page.dart';
import '../service/serviceapi.dart';
import '../models/houseproduct.dart';
import '../models/ui/my_house_model.dart';
import '../models/ui/plan_model.dart';
import '../widgets/house_card.dart';
import '../widgets/shadow_decoration.dart';
import '../service/baseapi.dart';

class MyHousesPage extends BasePage {
  final bool canPop;
  MyHousesPage({this.canPop = true});
  @override
  State<StatefulWidget> createState() {
    return MyHousesPageState();
  }

}

class MyHousesPageState extends BasePageState<MyHousesPage> {

  List<MyHouseModel> myHouseModels = List<MyHouseModel>();
  RefreshController _refreshController = RefreshController();
  bool _enablePullUp = false;
  int _curPageIndex = 0;
  IOTDeviceHouseSearch _searchRequest;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    title = "My Listing";
    _searchRequest = IOTDeviceHouseSearch(SearchType: 1, centerlongitude:0, centerlatitude:0, PageIndex: 0, PageSize: 50);
    _requestRefresh(true, false);

    
  }

  @override
  Widget getLeftAction() {
    if(widget.canPop == false) {
      return Container();
    }
    return super.getLeftAction();
  }

  void _requestRefresh(bool loading, bool readMore) async {
    if(readMore)
    {
      _curPageIndex += 1;
    }
    else
    {
      _curPageIndex = 0;
    }
    _searchRequest.PageIndex = _curPageIndex;
    if(loading)
      displayProgressIndicator(true);
    // 查询 myhouse
    var showingRequestScheduler = await UserServerApi().SearchIoTDeviceHouse(context, _searchRequest);

    if (showingRequestScheduler == null) {
      if(!loading) {
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      }
      showErrorMessage(context, "Error! please try later");
      if(loading)
        displayProgressIndicator(false);
      return;
    } else if(!loading){
        _refreshController.sendBack(!readMore, readMore == false ? RefreshStatus.completed: RefreshStatus.canRefresh);
    }

    List<MyHouseModel> dataModel = List<MyHouseModel>();
    if(showingRequestScheduler!= null) {
      showingRequestScheduler.ListObjects.forEach((element) {
        dataModel.add(
          MyHouseModel(
            houseModel: IOTDeviceHouseInfoModelToHouseModel(element), 
            showingAutoConfirmSettingList: element.ShowingAutoConfirmSettingList, 
            openRecordList: element.OpenRecordList, 
            showingRequestModels: element.ScheduledShowingRequestList, 
            showingMessageList: element.ShowingMessageList // TODO: VM， 此处为显示Message Count在MyList中
          )
        );
      });
    }

    if(loading)
      displayProgressIndicator(false);

    if(mounted) {
      setState(() {
        if(readMore == false) {
          this.myHouseModels.clear();
        }
        this.myHouseModels.addAll(dataModel);
        _enablePullUp = showingRequestScheduler.TotalCount > this.myHouseModels.length;

        displayScrollToTop();
      });
    }
  }

  @override
  void onScrollToTopPressed() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void _onRefresh(bool up) async {
    _requestRefresh(false, !up);
  }

  @override
  Widget pageContent(BuildContext context) {
  
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: _enablePullUp,
        onRefresh: _onRefresh,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: (myHouseModels == null || myHouseModels.length == 0) ? 1 :  myHouseModels.length,
            itemBuilder: (BuildContext context, int index) {
              if(myHouseModels == null || myHouseModels.length == 0) {
                  return _buildEmptyPage();
              }
              return InkWell(
                child: _buildHouseCard( myHouseModels[index]),
                onTap: (){
                  var myHouseModel = myHouseModels[index];
                  var planModel = PlanModel(house: myHouseModel.houseModel, isMyHouse: true, status: PlanStatus.none);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: planModel)));
                },
              );
            }
        )
    );
  }

  Widget _buildHouseCard(MyHouseModel model) {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        width: double.infinity,
        decoration: shadowDecoration(),
        child: HouseCard(
          model: model.houseModel, 
          messageCount: model.showingMessageList != null ? model.showingMessageList.length: 0,
          showMore: isAgent | isAgentAssistant,
        )
    );
  }

  Widget _buildEmptyPage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 86, 0, 0),
      child: Column(
        children: <Widget>[
          Image.asset('assets/icon_home_empty.png'),
          SizedBox(height: 10,),
          Text('Empty', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
        ],
      ),
    );
  }
}