import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import './appointment_details_page.dart';
import '../models/ui/plan_model.dart';
import '../widgets/plan_card.dart';
import './base_page.dart';
import '../models/showing.dart';
import '../service/serviceapi.dart';

class MyClientsRecordsPage extends BasePage {

  final String showingProfileGuid;

  MyClientsRecordsPage({this.showingProfileGuid});

  @override
  State<MyClientsRecordsPage> createState() {
    return MyClientsRecordsPageState();
  }

}

class MyClientsRecordsPageState extends BasePageState<MyClientsRecordsPage> {
  RefreshController _refreshController = RefreshController();
  List<PlanModel> showingRequests = List<PlanModel>();
  bool _enablePullUp;
  int _curPageIndex = 0;
  ShowingScheduleSearch _searchRequest;

  @override
  void initState() {
    super.initState();
    title = "Client Records";
    _searchRequest = ShowingScheduleSearch(StartCreateTime: 0, EndCreateTime: 0,ShowingProfileGuid:widget.showingProfileGuid, PageIndex: 0, PageSize: 50, RequestStatus: 0);
    _requestRefresh(true, false);
  }
  @override
  Widget pageContent(BuildContext context) {
    if (showingRequests == null || showingRequests.length == 0) {
      return _buildEmptyPage();
    }
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: _enablePullUp,
        onRefresh: _onRefresh,
        child: ListView.builder(
            itemCount: showingRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: PlanCard(model: showingRequests[index], onRequestMessagePageRefresh: (String message) {
                  _onRequestRefresh(context, message);},),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: showingRequests[index],)));
                },
              );
            }
        )
    );
  }

  void _onRefresh(bool up) async {
    _requestRefresh(false, !up);
  }

  void _onRequestRefresh(BuildContext context, String message) {
    if(message == null) {
      _requestRefresh(true, false);
    } else {
      showErrorMessage(context, message);
    }
  }

  void _requestRefresh(bool loading, bool readMore) async {
    if(readMore)
    {
      _curPageIndex += 1;
    }
    else
    {
      this.showingRequests.clear();
      _curPageIndex = 0;
    }
    _searchRequest.PageIndex = _curPageIndex;
    if(loading)
      displayProgressIndicator(true);
    // 查询 expired plan
    PagedListShowingRequestModel showingRequestScheduler = await UserServerApi().SearchShowingSchedules(context, _searchRequest);

    if (showingRequestScheduler == null) {
      if(!loading)
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      if(loading)
        displayProgressIndicator(false);
      return;
    } else if(!loading){
      _refreshController.sendBack(!readMore, RefreshStatus.canRefresh);
    }

    List<PlanModel> dataModel = List<PlanModel>();
    if(showingRequestScheduler != null) {
      showingRequestScheduler.ListObjects.forEach((element) {
        var planModel = ShowingRequestModelToPlanModel(element);
        dataModel.add(planModel);
      });
    }
    if(loading)
      displayProgressIndicator(false);

    if(mounted) {
      setState(() {
        this.showingRequests.addAll(dataModel);
        _enablePullUp = showingRequestScheduler.TotalCount > this.showingRequests.length;
      });
    }
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