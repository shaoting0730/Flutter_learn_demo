import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import '../models/showing.dart';
import '../widgets/message_cell.dart';
import '../service/serviceapi.dart';
import '../pages/message_page.dart';
import '../widgets/search_box.dart';

class MessagePostPage extends StatefulWidget {

  final OnRequestMessagePageRefresh onRequestMessagePageRefresh;
  final MessagePageState parentPage;
  MessagePostPage({this.onRequestMessagePageRefresh, Key key, this.parentPage}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return MessagePostPageState();
  }

}

class MessagePostPageState extends State<MessagePostPage> {

  RefreshController _refreshController = RefreshController();
  bool _enablePullUp;
  int _curPageIndex = 0;
  bool _loading = false;
  List<ShowingRequestModel> showingRequests = List<ShowingRequestModel>();
  ScrollController _scrollController = ScrollController();
  var _searchBoxKey = GlobalKey<SearchBoxState>();

  @override
  void initState() {
    super.initState();
    _curPageIndex = 0;
    setState(() {
      _loading = true;
    });
    _requestRefresh(true, false);
  }
  void OnSearchTap()
  {
    _requestRefresh(true, false);
  }
  @override
  Widget build(BuildContext context) {
    if(showingRequests == null || showingRequests.length == 0) {
      if(_loading)
        return _buildLoadingPage();
        
    }
    return  Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBox(key: _searchBoxKey, onFilterButtonTap: null, placeHolder: 'MLS Number', onSearch:OnSearchTap),
            ),
            Expanded(
              child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: _enablePullUp,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: showingRequests.length == 0 ? 1 : showingRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(showingRequests.length == 0) {
                        return _buildEmptyPage();
                      }
                      if(index < showingRequests.length) {
                        var model = showingRequests[index];
                        return Container(
                          child: MessageCell(message: model, disable: false, MessageType: 1, onRequestMessagePageRefresh: widget.onRequestMessagePageRefresh,),
                        );
                      }
                    },
                  )
              ),
            ),
          ],
        )
    );
  }
  void scrollToTop() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
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
    // 查询  plan
    PagedListShowingRequestModel showingRequestScheduler = await UserServerApi().SearchShowingRequestApprovalLogs(context,_searchBoxKey.currentState==null?'':_searchBoxKey.currentState.text(), _curPageIndex, 20);

    if (showingRequestScheduler == null) {
      if(!loading)
        _refreshController.sendBack(!readMore, RefreshStatus.failed);
      if(mounted) {
        setState(() {
          _loading = false;
          this.showingRequests = List<ShowingRequestModel>();
        });
      }
      return;
    } else if(!loading){
      _refreshController.sendBack(!readMore, RefreshStatus.canRefresh);
    }

    List<ShowingRequestModel> dataModel = List<ShowingRequestModel>();
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

      widget.parentPage.displayScrollToTop();
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