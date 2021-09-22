import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'appointment_details_page.dart';
import '../models/ui/plan_model.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/house_card.dart';
import '../models/houseproduct.dart';
import '../service/serviceapi.dart';

class SearchResultPage extends StatefulWidget {

  final List<HouseModel> houses;
  final IOTDeviceHouseSearch request;
  SearchResultPage({this.houses, this.request, Key key}):super(key:key);

  @override
  State<SearchResultPage> createState() {
    return SearchResultPageState();
  }

}

class SearchResultPageState extends State<SearchResultPage> {
  
  RefreshController _refreshController = RefreshController();

  bool _enablePullUp;
  IOTDeviceHouseSearch _request;
  List<HouseModel> _houses;
  int _curPageIndex = 0;
  var _scrollingController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _houses = widget.houses;
    _enablePullUp = !(widget.houses.length < 10);
    _request = widget.request;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: _enablePullUp,
        onRefresh: _onRefresh,
        child: ListView.builder(
          controller: _scrollingController,
          itemCount: _houses.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: _buildHouseCard( _houses[index]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: PlanModel(house: _houses[index], status: PlanStatus.none))));
              },
            );
          }
        )
      )
    );
  }

  void _onRefresh(bool up) async {
    if(up) {
      _requestRefresh();
    } else {
      _requestMore();
    }
  }

  void _requestRefresh() async {
    _request.PageIndex = 0;
    _request.PageSize = 10;
    _curPageIndex = 0;
    PagedListIOTDeviceHouseInfo models = await UserServerApi().SearchIoTDeviceHouse(context, _request);

    if (models == null) {
      _refreshController.sendBack(true, RefreshStatus.failed);
      return;
    } else {
      _refreshController.sendBack(true, RefreshStatus.completed);
    }

    List<HouseModel> houses = List<HouseModel>();
    models.ListObjects.forEach((element) {
      var houseModel = IOTDeviceHouseInfoModelToHouseModel(element);
      houseModel.houseInfo = element.HouseInfo;
      houseModel.deviceInfo = element.DeviceInfo;
      houses.add(houseModel);
    });
    
    if(mounted) {   
      setState(() {
        _houses = houses;
      });

    }
  }

  void _requestMore() async {
    _curPageIndex += 1;
    _request.PageIndex = _curPageIndex;
    _request.PageSize = 10;

    PagedListIOTDeviceHouseInfo models = await UserServerApi().SearchIoTDeviceHouse(context, _request);

    if (models == null) {
      _refreshController.sendBack(false, RefreshStatus.failed);
      return;
    } else {
      _refreshController.sendBack(false, RefreshStatus.idle);
    }

    List<HouseModel> houses = List<HouseModel>();
    models.ListObjects.forEach((element) {
      var houseModel = IOTDeviceHouseInfoModelToHouseModel(element);
      houseModel.houseInfo = element.HouseInfo;
      houseModel.deviceInfo = element.DeviceInfo;
      houses.add(houseModel);
    });
    
    if(mounted) {   
      setState(() {
        _houses.addAll(houses);
        _enablePullUp = models.TotalCount > _houses.length;
      });
    }
  }

  Widget _buildHouseCard(HouseModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: double.infinity,
      decoration: shadowDecoration(),
      child: HouseCard(model: model, displayFavorite: true,)
    );
  }

  void scrollToTop() {
    _scrollingController.jumpTo(_scrollingController.position.minScrollExtent);
  }

}