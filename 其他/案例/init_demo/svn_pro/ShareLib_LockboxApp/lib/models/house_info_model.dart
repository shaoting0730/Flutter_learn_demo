
class HouseInfoModel {
  
  String price;
  String address;
  String mls;
  String thumbnail = "https://i.pinimg.com/736x/c4/72/06/c472069bccf5658b275dcb1955824c9a--cute-little-houses-little-cottages.jpg";
  int bedroom = 3;
  int bathroom = 2;
  int parkingSpace = 1;
  HouseInfoModel({this.price, this.address, this.mls});
}

class HouseInfoModuleServcieApi {

  
}


class NearbyHouseInfoServiceApi extends HouseInfoModuleServcieApi {

  List<HouseInfoModel> list() {
    var models =List<HouseInfoModel>();

    for(int i = 0; i < 20 ; i ++ ) {
      var model =HouseInfoModel(address: "Customer Service PO Box 81226 Seattle, WA 98108-1226", price: "\$36,900", mls: "ld000000123");
      models.add(model);
    }

    return models;
  }
}