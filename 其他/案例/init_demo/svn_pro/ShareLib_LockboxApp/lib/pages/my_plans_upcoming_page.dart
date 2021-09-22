import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import './appointment_details_page.dart';
import '../models/ui/plan_model.dart';
import '../widgets/plan_card.dart';
import '../models/showing.dart';
import '../service/serviceapi.dart';

class UpcomingPlanPage extends StatefulWidget {
  final OnRequestMessagePageRefresh onRequestMessagePageRefresh;
  UpcomingPlanPage({this.onRequestMessagePageRefresh, Key key}):super(key:key);

  @override
  State<UpcomingPlanPage> createState() {
    return UpcomingPlanPageState();
  }
}

class UpcomingPlanPageState extends State<UpcomingPlanPage> {

  RefreshController _refreshController = RefreshController();
  bool _enablePullUp;
  int _curPageIndex = 0;
  ShowingScheduleSearch _searchRequest;
  List<PlanModel> showingRequests = List<PlanModel>();
  bool _loading = false;

  var _scrollingController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchRequest = ShowingScheduleSearch(StartCreateTime: DateTimeToTicks(DateTime.now().toUtc()), EndCreateTime: 0, SortBy: 'asc', PageIndex: 0, PageSize: 50, RequestStatus: 0);
    setState(() {
      _loading = true;
    });
    _requestRefresh(true, false);
  }

  @override
  Widget build(BuildContext context) {
    if(showingRequests == null || showingRequests.length == 0) {
      if(_loading)
        return _buildLoadingPage();
      
    }
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: _enablePullUp,
        onRefresh: _onRefresh,
        child: ListView.builder(
            controller: _scrollingController,
            itemCount: showingRequests.length == 0 ? 1 : showingRequests.length,
            itemBuilder: (BuildContext context, int index) {
              if(showingRequests.length == 0) {
                return _buildEmptyPage();
              }
              return InkWell(
                  child: PlanCard(model: showingRequests[index], onRequestMessagePageRefresh:widget.onRequestMessagePageRefresh, onDismissed: (model) {
                    setState(() {
                      showingRequests.remove(model);
                    });
                  }),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: showingRequests[index],)));
                  }
              );
            }
        )
    );
  }

  void scrollToTop() {
    _scrollingController.jumpTo(_scrollingController.position.minScrollExtent);
  }

  void _onRefresh(bool up) async {
    _requestRefresh(false, !up);
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
    // 查询  plan
    PagedListShowingRequestModel showingRequestScheduler = await UserServerApi().SearchShowingSchedules(context, _searchRequest);

    if (showingRequestScheduler == null) {
      if(!loading)
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      setState(() {
        _loading = false;
        this.showingRequests = List<PlanModel>();
      });
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

    if(mounted) {
      setState(() {
        _loading = false;
        this.showingRequests.addAll(dataModel);
        _enablePullUp = showingRequestScheduler.TotalCount > this.showingRequests.length;
      });
    }
  }

  Widget _buildLoadingPage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 86, 0, 0),
      child: Column(
        children: <Widget>[
          Image.asset('assets/icon_home_loading.png'),
          SizedBox(height: 10,),
          Text('Loading.......', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282)),)
        ],
      ),
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