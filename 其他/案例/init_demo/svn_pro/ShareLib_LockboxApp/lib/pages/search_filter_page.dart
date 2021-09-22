import 'package:flutter/material.dart';
import '../widgets/price_picker.dart';
import '../widgets/property_type.dart';
import '../widgets/room_number_picker.dart';

typedef SearchCallback = void Function(BuildContext context, String keyword);

const String TransactionType_SaleOrRent = "Sale or Rent";
const String TranscationType_Sale = "Sale";
const String TranscantionType_Rent = "Rent";

const String SortBy_LowToHigh = "Low to High (\$)";
const String SortBy_HighToLow = "High to Low (\$)";
const String SortBy_Date_NewToOld = "Date Posted: New to Old";
const String SortBy_Date_OldToNew = "Date Posted: Old to New";

class SearchFilterPage extends StatefulWidget {

  final SearchCallback onSearchPressed;
  SearchFilterPage({this.onSearchPressed, Key key}): super(key:key);

  @override
  State<SearchFilterPage> createState() {
    return SearchFilterPageState();
  }

}

class SearchFilterPageState extends State<SearchFilterPage> {

  final _minPriceKey = GlobalKey<PricePrickerState>();
  final _maxPriceKey = GlobalKey<PricePrickerState>();
  final _bedRoomKey = GlobalKey<RoomNumberPickerState>();
  final _bathRoomKey = GlobalKey<RoomNumberPickerState>();

  final _sortByKey = GlobalKey<PricePrickerState>();
  final _transactionTypeKey = GlobalKey<PricePrickerState>();

  var _propertyTypes = List<bool>();

  void clear() {
    _minPriceKey.currentState.clear();
    _maxPriceKey.currentState.clear();
    _bedRoomKey.currentState.clear();
    _bathRoomKey.currentState.clear();
    _sortByKey.currentState.clear();
    _transactionTypeKey.currentState.clear();
    setState(() {
      _propertyTypes = _resetPropertyTypes();
    });
  }

  @override
  void initState() {
    super.initState();
    _propertyTypes = _resetPropertyTypes();

  }

  List<bool> _resetPropertyTypes() {
    var result = List<bool>();
    for(int i = 0 ; i < 30; i ++) {
      result.add(false);
    }
    return result;
  }

  List<int> getPropertyTypes() {
    var result = List<int>();
    for(int i = 0 ; i < _propertyTypes.length ; i ++ ) {
      if(_propertyTypes[i]) {
        result.add(i);
      }
    }
    return result;
  }

  double getMinPrice() {
    var value = _minPriceKey.currentState.selectedValue;
    if(value == "" || value == 'Unlimited') {
      return 0;
    } else {
      return double.parse(value.replaceAll(',', ''));
    }
  }

  double getMaxPrice() {
    String value = _maxPriceKey.currentState.selectedValue;
    if(value == 'Unlimited' || value == "") {
      return 0;
    } else {
      return double.parse(value.replaceAll(',', ''));
    }
  }

  int getBedRoom() => _bedRoomKey.currentState.getSelectedNumber();

  int getBathRoom() => _bathRoomKey.currentState.getSelectedNumber();

  int getTranscationTypeId() {
    String value = _transactionTypeKey.currentState.selectedValue;
    
    if(value == TransactionType_SaleOrRent) {
      return 1;
    } else if(value == TranscationType_Sale)  {
      return 2;
    } else if(value == TranscantionType_Rent) {
      return 3;
    } else {
      return 1;
    }
  }

  List<String> getSortedBy() {
    String value = _sortByKey.currentState.selectedValue;
    if(value == SortBy_LowToHigh) {
      return ["price", "asc"];
    } else if(value == SortBy_HighToLow) {
      return ["price", "desc"];
    } else if(value == SortBy_Date_NewToOld) {
      return ["contractdate", "desc"];
    } else if(value == SortBy_Date_OldToNew)  {
      return ["contractdate", "asce"];
    }
    return ["",""];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: _buildFilterPanel(),
        ),
        Positioned(
          bottom: 0,
          child: _buildSearchBox(),
        )
      ]
    );
  }
  
  Widget _buildFilterPanel() {
    return SafeArea(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPriceSection(),
          _buildOrderBySection(),
          _buildTranscationType(),
          _buildBedRoom(),
          SizedBox(height: 10,),
          _buildBathRoom(),
          SizedBox(height: 10,),
          _buildPropertyType(),
          SizedBox(height: 100,),
        ],
      )
    );
  }

  Widget _buildSearchBox() {
    return Container(
       decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x20000000),
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ]
      ),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment(0, 0),
      child:SafeArea(
        child: SizedBox(
          width: 200,
          height: 44,
          child: RaisedButton(
            child: Text("Search"),
            onPressed: () {
              widget.onSearchPressed(context, "");
            },
            color: Colors.red,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.red,)
            )
          ),
          )
        )
    );
  }
  

  Widget _buildBathRoom() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Bath Room"),
          SizedBox(height: 15,),
          RoomNumberPicker(key: _bathRoomKey)
        ]
      )
    );
  }


  Widget _buildBedRoom() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Bed Room"),
          SizedBox(height: 15,),
          RoomNumberPicker(key: _bedRoomKey)
        ]
      )
    );
  }

  Widget _buildPropertyType() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle("Property type"),
          SizedBox(height: 15,),
          Container(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                PropertyType(key:Key(DateTime.now().toString()), title: "Any", isSelected: _propertyTypes[0], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes = _resetPropertyTypes();

                    _propertyTypes[0] = isSelected;
                  });
                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "House", isSelected: _propertyTypes[1], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[1] = isSelected;
                  });
                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Duplex",isSelected: _propertyTypes[2], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[2] = isSelected;
                  });
                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Triplex", isSelected: _propertyTypes[3], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[3] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Residential Commercial Mix", isSelected: _propertyTypes[5], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[5] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Mobile Home", isSelected: _propertyTypes[6], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[6] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Special Purpose", isSelected: _propertyTypes[12], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[12] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Other", isSelected: _propertyTypes[14], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[14] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Row Townhouse", isSelected: _propertyTypes[16], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[16] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Apartment", isSelected: _propertyTypes[17], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[17] = true;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Fourplex", isSelected: _propertyTypes[19], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[19] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "GardenHome", isSelected: _propertyTypes[20], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[20] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Manufactured Home Mobile", isSelected: _propertyTypes[27], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[27] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Commercial Apartment", isSelected: _propertyTypes[28], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[28] = isSelected;
                  });

                }),
                PropertyType(key:Key(DateTime.now().toString()), title: "Manufactured Home", isSelected: _propertyTypes[29], onSelected: (isSelected) {
                  setState(() {
                    _propertyTypes[0] = false;
                    _propertyTypes[29] = isSelected;
                  });
                }),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildOrderBySection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildSectionTitle("Sort by"),
          Container(
            height: 40,
            child: PricePicker(placeholder: 'Sort by: Featured ', priceOptions: <String>[SortBy_LowToHigh, SortBy_HighToLow, SortBy_Date_NewToOld, SortBy_Date_OldToNew], key: _sortByKey)
          )
        ],
      )
    );
  }

  Widget _buildTranscationType() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildSectionTitle("Transaction Type"),
          Container(
            height: 40,
            child: PricePicker(placeholder: 'Transcation Type: All', priceOptions: <String>[TransactionType_SaleOrRent, TranscationType_Sale, TranscantionType_Rent], key: _transactionTypeKey)
          )
        ],
      )
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildSectionTitle("Price"),
          Container(
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(child:PricePicker(placeholder: 'Min price', priceOptions: <String>["Unlimited","2,5000","5,0000","7,5000","100,000","125,000","150,000","175,000","200,000","225,000","250,000","275,000","300,000","425,000","450,000","475,000","500,000","550,000","600,000","650,000","700,000","750,000","800,000","850,000","900,000","950,000","1,000,000","1,100,000","1,200,000","1,300,000","1,400,000","1,500,000","1,600,000","1,700,000","1,800,000","1,900,000","2,000,000","2,500,000","3,000,000","3,500,000","4,000,000","4,500,000","5,000,000","5,500,000","6,000,000","6,500,000","7,000,000","7,500,000","10,000,000","15,000,000","20,000,000"], key: _minPriceKey)),
                Divider(height: 10, color: Color(0xFFCCCCCC)),
                Flexible(child:PricePicker(placeholder: 'Max price', priceOptions:<String>["Unlimited", "2,5000","5,0000","7,5000","100,000","125,000","150,000","175,000","200,000","225,000","250,000","275,000","300,000","425,000","450,000","475,000","500,000","550,000","600,000","650,000","700,000","750,000","800,000","850,000","900,000","950,000","1,000,000","1,100,000","1,200,000","1,300,000","1,400,000","1,500,000","1,600,000","1,700,000","1,800,000","1,900,000","2,000,000","2,500,000","3,000,000","3,500,000","4,000,000","4,500,000","5,000,000","5,500,000","6,000,000","6,500,000","7,000,000","7,500,000","10,000,000","15,000,000","20,000,000"], key: _maxPriceKey))
              ],
            )
          )
        ],
      )
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
    );
  }
}