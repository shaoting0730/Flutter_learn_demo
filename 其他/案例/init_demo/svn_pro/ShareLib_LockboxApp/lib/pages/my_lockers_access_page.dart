import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import '../service/baseapi.dart';
import '../widgets/my_locker_cell.dart';
import '../service/serviceapi.dart';
import '../models/iotdevice.dart';
import './my_locker_details_page.dart';

class MyAccessLockboxPage extends StatefulWidget {
  MyAccessLockboxPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return MyAccessLockboxPageState();
  }
}

class MyAccessLockboxPageState extends State<MyAccessLockboxPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'empty':'Empty',
      'loading': 'loading...'
    },
    'zh': {
      'empty':'空',
      'loading': '加载中...'
    },
  };
  RefreshController _refreshController = RefreshController();
  bool _enablePullUp = false;
  int _curPageIndex = 0;
  bool _loading = false;
  IOTDeviceInfoSearch _searchRequest;
  List<IOTDeviceInfoModel> showingRequests = List<IOTDeviceInfoModel>();
  var _scrollingController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchRequest = IOTDeviceInfoSearch(PageIndex: 0, PageSize: 50, SearchType: 2);
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
              return Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child:InkWell(
                    child: MyLockerCell(lockerModel: showingRequests[index], displayDueTime: true, displayAuthor: true, onDismissed: (model) {
                      setState(() {
                        showingRequests.remove(model);
                      });
                    }),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyLockerDetailsPage(deviceInfo: showingRequests[index],isMyLockbox: false,)));
                    }
                ) 
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
    PagedListIOTDeviceInfoModel showingRequestScheduler = await UserServerApi().SearchIoTDevices(context, _searchRequest);

    if (showingRequestScheduler == null) {
      if(!loading)
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      setState(() {
        _loading = false;
        this.showingRequests = List<IOTDeviceInfoModel>();
      });
      return;
    } else if(!loading){
      _refreshController.sendBack(!readMore, RefreshStatus.canRefresh);
    }

    List<IOTDeviceInfoModel> dataModel = List<IOTDeviceInfoModel>();
    if(showingRequestScheduler != null) {
      showingRequestScheduler.ListObjects.forEach((element) {
        dataModel.add(element);
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
          Text(_localizedValues[getLocaleCode()]["loading"], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF536282)),)
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
          Image.asset('assets/ico_home_empty.png'),
          SizedBox(height: 10,),
          Text(_localizedValues[getLocaleCode()]["empty"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
        ],
      ),
    );
  }
}