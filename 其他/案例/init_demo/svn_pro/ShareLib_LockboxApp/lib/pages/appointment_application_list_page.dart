import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'base_page.dart';
import '../models/showing.dart';
import '../widgets/application_cell.dart';
import '../service/serviceapi.dart';

class AppointmentApplicationListPage extends BasePage {

  final String HouseGuid;
  final String AddressText;
  AppointmentApplicationListPage({this.HouseGuid, this.AddressText});

  @override
  State<StatefulWidget> createState() {
    return AppointmentApplicationListPageState();
  }

}

class AppointmentApplicationListPageState extends BasePageState<AppointmentApplicationListPage> {

  ShowingScheduleSearch _searchRequest;
  List<ShowingRequestModel> showingRequests = List<ShowingRequestModel>();
  bool _loading = false;
  RefreshController _refreshController = RefreshController();
  bool _enablePullUp;
  int _curPageIndex = 0;

  @override
  void initState() {
    super.initState();
    title = widget.AddressText;
    _searchRequest = ShowingScheduleSearch(StartCreateTime: 0, EndCreateTime: 0, PageIndex: 0, PageSize: 50, RequestStatus: 0, HouseProductGuid:widget.HouseGuid, StoreCustomerGuid:UserServerApi().getStoreCustomerGuid());
    setState(() {
      _loading = true;
    });
    _requestRefresh(true, false);
  }

  @override
  Widget pageContent(BuildContext context) {
    if(showingRequests == null || showingRequests.length == 0) {
      if(_loading)
        return _buildLoadingPage();
      else
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
            var request = showingRequests[index];
            return ApplicationCell(message: request, isShowCustomerName: true, onRequestPageRefresh: (String errorMessage) {
              if(errorMessage != null) {
                showErrorMessage(context, errorMessage);
              }
            });
          },
        )
    );
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
        this.showingRequests = List<ShowingRequestModel>();
      });
      return;
    } else if(!loading){
      _refreshController.sendBack(!readMore, RefreshStatus.canRefresh);
    }

    if(mounted) {
      setState(() {
        _loading = false;
        this.showingRequests.addAll(showingRequestScheduler.ListObjects);
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