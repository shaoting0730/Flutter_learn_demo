import 'package:flutter/material.dart';
import 'base_page.dart';
import '../widgets/search_box.dart';
import '../service/serviceapi.dart';
import '../models/houseproduct.dart';
import '../models/ui/plan_model.dart';
import './search_filter_page.dart';
import './search_result_dart.dart';

class SearchPage extends BasePage {
  @override
  State<SearchPage> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends BasePageState<SearchPage> {

  SearchFilterPage _searchFilter;
  var _searchBoxKey = GlobalKey<SearchBoxState>();
  var _searchFilerKey = GlobalKey<SearchFilterPageState>();
  var _searchResultKey = GlobalKey<SearchResultPageState>();

  Widget _curPage;

  findDevices(BuildContext context) async{
    displayProgressIndicator(true);
    var request = new IOTDeviceHouseSearch();
    request.PageIndex = 0;
    request.PageSize = 10;
    request.SearchType = 0;
    request.centerlatitude = 0;
    request.centerlongitude = 0;
    var searchCriteria = RealtorOpenAPISearchModel(
      BathRangeMax: _searchFilerKey.currentState.getBathRoom(), 
      BathRangeMin: _searchFilerKey.currentState.getBathRoom(),
      BedRangeMax: _searchFilerKey.currentState.getBedRoom(),
      BedRangeMin: _searchFilerKey.currentState.getBedRoom(),
      PriceMax: _searchFilerKey.currentState.getMaxPrice(),
      PriceMin: _searchFilerKey.currentState.getMinPrice(),
      Keywords: _searchBoxKey.currentState.text(),
      
    );
    if(searchCriteria.BathRangeMax==5)
      searchCriteria.BathRangeMax = 0;
    if(searchCriteria.BedRangeMax==5)
      searchCriteria.BedRangeMax = 0;

    searchCriteria.BuildingTypeId = _searchFilerKey.currentState.getPropertyTypes();
    searchCriteria.TransactionTypeId = _searchFilerKey.currentState.getTranscationTypeId();
    var sortOrderBy = _searchFilerKey.currentState.getSortedBy();
    searchCriteria.SortBy = sortOrderBy[0];
    searchCriteria.SortOrder = sortOrderBy[1];
    request.SearchCriteria = searchCriteria;
    
    PagedListIOTDeviceHouseInfo models = await UserServerApi().SearchIoTDeviceHouse(context, request);

    displayProgressIndicator(false);
    if (models == null) {
      showErrorMessage(context, "Errors! please try again");
      return;
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
        _curPage =SearchResultPage(houses: houses,request: request, key:_searchResultKey);
        _searchBoxKey.currentState.enableEditing(false);
        displayScrollToTop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title = 'Find a home';
    _searchFilter = SearchFilterPage(onSearchPressed: (BuildContext context, String keyword){
      _onSearchPressed(context, keyword);
    }, key: _searchFilerKey);

    _curPage =_searchFilter;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget pageContent(BuildContext context) {

    var list = List<Widget>();
    var searchboxWidth = _curPage == _searchFilter ? MediaQuery.of(context).size.width - 100 : MediaQuery.of(context).size.width - 30;
    list.add(
      InkWell(
        onTap: () {
          _onTapSearchBoxFilterButton();
        },
        child: Container(
          width: searchboxWidth,
          margin: const EdgeInsets.fromLTRB(15, 15, 5, 15),
          child: SearchBox(key: _searchBoxKey, onFilterButtonTap: _onTapSearchBoxFilterButton,),      
        ),
      )
    );
    if(_curPage == _searchFilter) {
      list.add(
        InkWell(
          onTap: () {
            _onTapClear();
          },
          child: Container(
            alignment: AlignmentDirectional.center,
            height: 40,
            padding: const EdgeInsets.only(left: 10),
            child: Text('Clear', style: TextStyle(fontSize: 20),),
          )
        )
      );
    }

    var stack = List<Widget>();
    if(_curPage == _searchFilter) {
      stack.add(_searchFilter);
    } else {
      stack.add(_searchFilter);
      stack.add(_curPage);
    }

    return Container(
      
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children:list
          ),
          Expanded(
            child: Stack(
              children: stack
            )
            
          )
        ],
      ),
    );
  }

  Widget getLeftAction() {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: (){
        FocusScope.of(scaffoldKey.currentContext).requestFocus(new FocusNode());
        if(_curPage == _searchFilter) {
          Navigator.pop(scaffoldKey.currentContext);
        } else {
          setState(() {
            _searchBoxKey.currentState.showClearIcon();
            _curPage = _searchFilter;
            hidenScrollToTop();
            _searchBoxKey.currentState.enableEditing(true);
          });
        }

      },
    );

  }

  void _onSearchPressed(BuildContext context, String keyword) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    findDevices(context);
    _searchBoxKey.currentState.showFilterIcon();
  }

  void _onTapSearchBoxFilterButton() {
    setState(() {
      _curPage = _searchFilter;
      hidenScrollToTop();
      _searchBoxKey.currentState.enableEditing(true);
    });
  }

  void _onTapClear() {
    _searchBoxKey.currentState.clear();
    _searchFilerKey.currentState.clear();
  }

  @override
  void onScrollToTopPressed() {
    if(_searchResultKey.currentState != null) {
      _searchResultKey.currentState.scrollToTop();
    }
  }
}