import 'package:flutter/material.dart';
import 'base_page.dart';
import '../widgets/client_cell.dart';
import 'add_client_page.dart';
import '../widgets/empty_state.dart';
import '../service/serviceapi.dart';
import '../models/showing.dart';
import './my_clients_reconds_page.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class MyClientsPage extends BasePage {
  @override
  State<StatefulWidget> createState() {
    return MyClientsPageState();
  }

}

class MyClientsPageState extends BasePageState<MyClientsPage>  {

  List<ShowingProfileModel> models = List<ShowingProfileModel>();
  RefreshController _refreshController = RefreshController();
  bool _enablePullUp;
  int _curPageIndex = 0;
  ShowingProfileSearch _searchRequest;

  @override
  void initState() {
    super.initState();
    title = "My clients";
    _searchRequest = ShowingProfileSearch(PageIndex: 0, PageSize: 50);
    setState(() {
      _requestRefresh(context, true, false);  
    });
    
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  void _requestRefresh(BuildContext context, bool loading, bool readMore) async {
    if(readMore)
    {
      _curPageIndex += 1;
    }
    else
    {
      this.models.clear();
      _curPageIndex = 0;
    }
    _searchRequest.PageIndex = _curPageIndex;
    if(loading)
      displayProgressIndicator(true);
    // 查询
    var showingRequestScheduler = await UserServerApi().SearchProfiles(context, _searchRequest);

    if (showingRequestScheduler == null) {
      if(!loading)
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      showErrorMessage(context, "Error! please try later");
      if(loading)
        displayProgressIndicator(false);
      return;
    } else if(!loading){
      _refreshController.sendBack(!readMore, RefreshStatus.canRefresh);
    }

    List<ShowingProfileModel> dataModel = List<ShowingProfileModel>();
    if(showingRequestScheduler!= null) {
      showingRequestScheduler.ListObjects.forEach((element) {
        dataModel.add(element);
      });
    }

    if(loading)
      displayProgressIndicator(false);

    if(mounted) {
      setState(() {
        this.models.addAll(dataModel);
        _enablePullUp = showingRequestScheduler.TotalCount > this.models.length;
      });
    }
  }

  void _onRefresh(bool up) async {
    _requestRefresh(context, false, !up);
  }

  @override
  Widget pageContent(BuildContext context) {

    if(models.length == 0)  {
      return EmptyRecord();
    }
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: _enablePullUp,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: models.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  if(models[index].TotalShowingRequests>0)
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyClientsRecordsPage(showingProfileGuid: models[index].Guid)));
                },
                child: ClientCell(model: models[index])
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
          Navigator.push(scaffoldKey.currentContext, MaterialPageRoute(builder: (context) => AddClientPage(addSuccessCallback: () {
            _requestRefresh(scaffoldKey.currentContext, true, false);
          },)));
        },
      ),
    ];
  }
}