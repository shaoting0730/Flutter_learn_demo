import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import '../service/baseapi.dart';
import '../widgets/my_locker_cell.dart';
import '../service/serviceapi.dart';
import '../models/iotdevice.dart';
import './my_locker_details_page.dart';
import './scan_new_lockbox_page.dart';

class MyOwnLockboxPage extends StatefulWidget {
  MyOwnLockboxPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return MyOwnLockboxPageState();
  }
}

class MyOwnLockboxPageState extends State<MyOwnLockboxPage> {

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'add_new_locker':"Add an new locker",
      'delete':'Delete',
      'empty':'Empty',
      'loading': 'loading...'
    },
    'zh': {
      'add_new_locker':"添加一个新的锁",
      'delete':'删除',
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
    _searchRequest = IOTDeviceInfoSearch(PageIndex: 0, PageSize: 50, SearchType: 1);
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
              if (showingRequests.length == 0) {
                return _buildEmptyPage();
              }
              var model = showingRequests[index];
              return Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: InkWell(
                    child: MyLockerCell(lockerModel: model, displaySharePWD:true),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyLockerDetailsPage(deviceInfo: model,isMyLockbox: true,)));
                    }
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: _localizedValues[getLocaleCode()]["delete"],
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        _removeLocker(model);
                      },
                    ),
                  ],
                )
              );
            }
        )
    );
  }

  
  void scrollToTop() {
    _scrollingController.jumpTo(_scrollingController.position.minScrollExtent);
  }

  void _removeLocker(IOTDeviceInfoModel request) {
    setState(() {
     showingRequests.remove(request) ;
     UserServerApi().DeleteIoTDevice(context, request.Guid);
    });
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
      if(mounted) {
        setState(() {
          _loading = false;
          this.showingRequests = List<IOTDeviceInfoModel>();
        });
      }
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
          Text(_localizedValues[getLocaleCode()]["empty"], style: TextStyle(fontSize: 14, color: Color(0xFF536282)),),
          SizedBox(height: 80,),
          Container(
            width: 200,
            height: 44,
            child: RaisedButton(
              child: Text(_localizedValues[getLocaleCode()]["add_new_locker"]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScanNewLockerPage()));
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
      ),
    );
  }
}