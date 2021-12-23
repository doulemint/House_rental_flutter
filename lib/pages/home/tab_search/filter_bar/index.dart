import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental/models/general_type.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/data.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/item.dart';
import 'package:house_rental/scoped_model/room_filter.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/utils/common_picker/common_picker.dart';

class FilterBar extends StatefulWidget {
  final ValueChanged<FilterBarResult> onChange;

  const FilterBar({Key key, this.onChange}) : super(key: key);

  @override
  _FilterBarState createState() => _FilterBarState();
}

String lastCityId;

class _FilterBarState extends State<FilterBar> {
  List<GeneralType> areaList = [];

  List<GeneralType> priceList = [];

  List<GeneralType> rentList = [];

   List<GeneralType> roomTypetList = [];

  List<GeneralType> orientList = [];

  List<GeneralType> floorList = [];

  bool isAreaActive = false;
  bool isRentTypeActivate = false;
  bool isPriceActive = false;
  bool isFilterActive = false;

  String areaID = '';
  String rentypeID = '';
  String priceID = '';
  List<String> moreIDs = [];

  _onAreaChange(context) {
    setState(() {
      isAreaActive = true;
    });
    var result = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: areaList.map((item) => item.name).toList(),
    );

    result.then((index) {
      if (index == null) return;
      setState(() {
        areaID = areaList[index].id;
      });
      _onChange();
    }).whenComplete(() {
      setState(() {
        isPriceActive = false;
      });
    });
  }

  //price
  _onPriceChange(context) {
    setState(() {
      isPriceActive = true;
    });
    var result = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: priceList.map((item) => item.name).toList(),
    );

    result.then((index) {
      if (index == null) return;
      setState(() {
        priceID = priceList[index].id;
      });
      _onChange();
    }).whenComplete(() {
      setState(() {
        isPriceActive = false;
      });
    });
  }

  _onRentTypeChange(context) {
    setState(() {
      isRentTypeActivate = true;
    });
    var result = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: rentList.map((item) => item.name).toList(),
    );

    result.then((index) {
      if (index == null) return;
      setState(() {
        areaID = rentList[index].id;
      });
      _onChange();
    }).whenComplete(() {
      setState(() {
        isRentTypeActivate = false;
      });
    });
  }

  _onFilterChange(context) {
    Scaffold.of(context).openEndDrawer();
  }

  _onChange() {
    var selectedList =
        ScopedModelHelper.getModel<FilterBarModel>(context).selectedList;
    if (widget.onChange != null) {
      widget.onChange(FilterBarResult(
          areaId: areaID,
          rentTypeId: rentypeID,
          priceId: priceID,
          moreIds: selectedList.toList()));
    }
  }

  _getData() async {
    var cityId = ScopedModelHelper.getAreaId(context);
    lastCityId = cityId;
    final url = '/houses/condition?id=$cityId';

    if (!this.mounted) return;
    var res = await DioHttp.of(context).get(url);
    var data = json.decode(res.toString())['body'];

    if (!this.mounted) {
      return;
    }

    List<GeneralType> areaList = List<GeneralType>.from(data['area']['children']
        .map((item) => GeneralType.fromJson(item))
        .toList());
    List<GeneralType> priceList = List<GeneralType>.from(
        data['price'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> rentTypeList = List<GeneralType>.from(
        data['rentType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> roomTypeList = List<GeneralType>.from(
        data['roomType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> orientedList = List<GeneralType>.from(
        data['oriented'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> floorList = List<GeneralType>.from(
        data['floor'].map((item) => GeneralType.fromJson(item)).toList());

    setState(() {
      this.areaList = areaList;
      this.priceList = priceList;
      this.rentList = rentTypeList;
      this.roomTypetList = roomTypeList;
      this.orientList = orientedList;
      this.floorList = floorList;
    });

    Map<String, List<GeneralType>> dataList = Map<String, List<GeneralType>>();
    dataList['roomTypeList'] = roomTypetList;
    dataList['orientedList'] = orientList;
    dataList['floorList'] = floorList;
    // ScopedModelHelper.getModel<FilterBarModel>(context).dataList= dataList;
  }

  @override
  void initState() {
    Timer.run(_getData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _onChange();
    if (lastCityId != null &&
        ScopedModelHelper.getAreaId(context) != lastCityId) {
      _getData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.0,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black12,
      ))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Item(
              title: '区域',
              isActive: isAreaActive,
              onTap: _onAreaChange,
            ),
            Item(
              title: '方式',
              isActive: isRentTypeActivate,
              onTap: _onRentTypeChange,
            ),
            Item(
              title: '租金',
              isActive: isPriceActive,
              onTap: _onPriceChange,
            ),
            Item(
              title: '筛选',
              isActive: isFilterActive,
              onTap: _onFilterChange,
            ),
          ]),
    );
  }
}
