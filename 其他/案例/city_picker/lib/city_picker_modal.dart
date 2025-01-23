import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ResultBlock = void Function(CityResult result);

class CityPickerModal extends StatefulWidget {
  final List params;
  final ResultBlock onResult;
  const CityPickerModal({super.key, required this.onResult, required this.params});
  @override
  State<CityPickerModal> createState() => _CityPickerModalState();
}

class _CityPickerModalState extends State<CityPickerModal> {
  List datas = [];
  int provinceIndex = 0;
  int cityIndex = 0;
  int areaIndex = 0;

  FixedExtentScrollController provinceScrollController = FixedExtentScrollController();
  FixedExtentScrollController cityScrollController = FixedExtentScrollController();
  FixedExtentScrollController areaScrollController = FixedExtentScrollController();

  late CityResult result = CityResult();

  bool isShow = false;

  List get provinces {
    if (datas.isNotEmpty) {
      return datas;
    }
    return [];
  }

  List get citys {
    if (provinces.isNotEmpty) {
      return provinces[provinceIndex]['children'] ?? [];
    }
    return [];
  }

  List get areas {
    if (citys.isNotEmpty) {
      List list = citys[cityIndex]['children'] ?? [];
      if (list.isNotEmpty) {}
      return list;
    }
    return [];
  }

  // 保存选择结果
  _saveInfoData() {
    var prs = provinces;
    var cts = citys;
    var ars = areas;
    if (prs.isNotEmpty) {
      result.province = prs[provinceIndex]['label'];
      result.provinceCode = prs[provinceIndex]['value'].toString();
    } else {
      result.province = '';
      result.provinceCode = '';
    }

    if (cts.isNotEmpty) {
      result.city = cts[cityIndex]['label'];
      result.cityCode = cts[cityIndex]['value'].toString();
    } else {
      result.city = '';
      result.cityCode = '';
    }

    if (ars.isNotEmpty) {
      result.area = ars[areaIndex]['label'];
      result.areaCode = ars[areaIndex]['value'].toString();
    } else {
      result.area = '';
      result.areaCode = '';
    }
  }

  @override
  void dispose() {
    provinceScrollController.dispose();
    cityScrollController.dispose();
    areaScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    //读取city.json数据
    datas = widget.params;
    setState(() {
      isShow = true;
    });

    //初始化控制器
    // provinceScrollController = FixedExtentScrollController(initialItem: 10);
    // cityScrollController = FixedExtentScrollController(initialItem: 0);
    // areaScrollController = FixedExtentScrollController(initialItem: 7);
    // setState(() {
    //   provinceIndex = 10;
    //   cityIndex = 0;
    //   areaIndex = 7;
    // });

    //初始化控制器
    provinceScrollController = FixedExtentScrollController();
    cityScrollController = FixedExtentScrollController();
    areaScrollController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _firstView(),
          _contentView(),
        ],
      ),
    );
  }

  Widget _firstView() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          InkWell(
            child: Text(
              '取消',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          InkWell(
            child: Text(
              '确定',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            onTap: () {
              widget.onResult(result);
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _contentView() {
    return SizedBox(
      height: 200,
      child: isShow
          ? Row(
              children: <Widget>[
                Expanded(child: _provincePickerView()),
                Expanded(child: _cityPickerModal()),
                Expanded(child: _areaPickerView()),
              ],
            )
          : const Center(
              child: CupertinoActivityIndicator(
                animating: true,
              ),
            ),
    );
  }

  Widget _provincePickerView() {
    return CupertinoPicker(
      scrollController: provinceScrollController,
      onSelectedItemChanged: (index) {
        provinceIndex = index;
        cityIndex = 0;
        if (cityScrollController.positions.isNotEmpty) {
          cityScrollController.jumpTo(0);
        }
        areaIndex = 0;
        if (areaScrollController.positions.isNotEmpty) {
          areaScrollController.jumpTo(0);
        }
        _saveInfoData();
        setState(() {});
      },
      itemExtent: 36,
      children: provinces.map((item) {
        return Center(
          child: Text(
            item['label'],
            style: const TextStyle(color: Colors.black87, fontSize: 16),
            maxLines: 1,
          ),
        );
      }).toList(),
    );
  }

  Widget _cityPickerModal() {
    return Container(
      child: citys.isEmpty
          ? Container()
          : CupertinoPicker(
              scrollController: cityScrollController,
              onSelectedItemChanged: (index) {
                cityIndex = index;
                areaIndex = 0;
                if (areaScrollController.positions.isNotEmpty) {
                  areaScrollController.jumpTo(0);
                }
                _saveInfoData();
                setState(() {});
              },
              itemExtent: 36,
              children: citys.map((item) {
                return Center(
                  child: Text(
                    item['label'],
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    maxLines: 1,
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _areaPickerView() {
    return SizedBox(
      width: double.infinity,
      child: areas.isEmpty
          ? Container()
          : CupertinoPicker(
              scrollController: areaScrollController,
              onSelectedItemChanged: (index) {
                areaIndex = index;
                _saveInfoData();
                setState(() {});
              },
              itemExtent: 36,
              children: areas.map((item) {
                return Center(
                  child: Text(
                    item['label'],
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    maxLines: 1,
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class CityResult {
  /// 省市区
  String? province = '';
  String? city = '';
  String? area = '';

  /// 对应的编码
  String? provinceCode = '';
  String? cityCode = '';
  String? areaCode = '';

  CityResult({
    this.province,
    this.city,
    this.area,
    this.provinceCode,
    this.cityCode,
    this.areaCode,
  });

  CityResult.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    city = json['city'];
    area = json['area'];
    provinceCode = json['provinceCode'];
    cityCode = json['cityCode'];
    areaCode = json['areaCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datas = <String, dynamic>{};
    datas['province'] = province;
    datas['city'] = city;
    datas['area'] = area;
    datas['provinceCode'] = provinceCode;
    datas['cityCode'] = cityCode;
    datas['areaCode'] = areaCode;

    return datas;
  }
}
