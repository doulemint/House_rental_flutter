import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental/models/room_list_item_data.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/data.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/filter_drawer.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/index.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/widgets/room_list_item_widget.dart';
import 'package:house_rental/widgets/search_bar/index.dart';

// import 'dataList.dart';

class Tabsearch extends StatefulWidget {
  @override
  _TabsearchState createState() => _TabsearchState();
}

class _TabsearchState extends State<Tabsearch> {
  List<RoomListItemData> list=[];

  _onFilterBarChange(FilterBarResult data) async{

    var cityId = Uri.encodeQueryComponent(ScopedModelHelper.getAreaId(context));
    var area = Uri.encodeQueryComponent(data.areaId);
    var mode = Uri.encodeQueryComponent(data.rentTypeId);

    var price = Uri.encodeQueryComponent(data.priceId);
    //price|2000=>2000;
    price = price.replaceAll('PRICE%7C', '');
    var more = Uri.encodeQueryComponent(data.moreIds.join(','));

    String url = '/houses?cityId=' +
        '$cityId&area=$area&rentType=$mode&price=$price&more=$more&start=1&end=20';
    var res = await DioHttp.of(context).get(url);
    var resMap = json.decode(res.toString());
    List dataMap = resMap['body']['list'];

    //print("get datamap");

    List<RoomListItemData> resList =
        dataMap.map((json) => RoomListItemData.fromJson(json)).toList();

    if (!mounted) return;

    setState(() {
      list = resList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FilterDrawer(),
      appBar: AppBar(
        actions: <Widget>[Container()],
        elevation: 0,
        title: SearchBar(
        showLocation:true,
        showMap:true,
        onSearch:(){
          Navigator.of(context).pushNamed('search');
        }
      ),),
      body: Column(children: <Widget>[
        Container(
        height: 41.0,
        child: FilterBar(
          onChange:
          _onFilterBarChange
          // (data){}
        ),),
        Expanded(child: ListView(
          children: list.map((f)=>
          // Container(
          //   height:200.0,
          //   margin: EdgeInsets.only(bottom:10.0),
          //   decoration:BoxDecoration(color:Colors.grey),
          // )
          RoomListItemWidget(f)).toList(),
        ))
      ]),
    );
  }
}