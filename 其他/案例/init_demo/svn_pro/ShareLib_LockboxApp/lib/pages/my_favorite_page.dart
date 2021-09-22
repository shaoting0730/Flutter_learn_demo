import 'package:flutter/material.dart';
import '../models/ui/plan_model.dart';
import '../widgets/shadow_decoration.dart';
import '../widgets/house_card.dart';
import '../service/serviceapi.dart';
import 'appointment_details_page.dart';
import 'base_page.dart';

class MyFavoritePage extends BasePage {


  final List<HouseModel> houses;
  MyFavoritePage({this.houses});

  @override
  State<StatefulWidget> createState() {
    return MyFavoritePageState();
  }

}

class MyFavoritePageState extends BasePageState<MyFavoritePage> {

  List<HouseModel> models = List<HouseModel>();
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    title = 'My Favorite';
    _loadingFavorites(context);
  }

  @override
  Widget pageContent(BuildContext context) {

    return ListView.builder(
      controller: _scrollController,
      itemCount: models.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: _buildHouseCard( models[index]),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsPage(planModel: PlanModel(house: models[index], status: PlanStatus.none), NeedRefreshHouseInfo:true)));
          },
        );
      }
    );
  }

  Widget _buildHouseCard(HouseModel model) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: double.infinity,
      decoration: shadowDecoration(),
      child: HouseCard(model: model, displayFavorite: true, isFavorite: true, onFavoritedClick: () {
        setState(() {
          models.remove(model);
        });
      },),
    );
  }

  void _loadingFavorites(BuildContext context) async {
    displayProgressIndicator(true);
    var wishes = await UserServerApi().LoadWishList(context);
    displayProgressIndicator(false);

    List<HouseModel> houses = List<HouseModel>();
    wishes.forEach((element) {
      var houseModel = HouseModel(
        houseInfo: element,
      );
      houses.add(houseModel);
    });
    
    if(mounted) {
      setState(() {
        models = houses;
      });

      displayScrollToTop();
    }
  }

  @override
  void onScrollToTopPressed() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }
}