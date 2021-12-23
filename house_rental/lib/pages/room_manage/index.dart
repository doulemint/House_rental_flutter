import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental/models/room_list_item_data.dart';
// import 'package:house_rental/pages/home/tab_search/dataList.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/widgets/common_floatbutton.dart';
import 'package:house_rental/widgets/room_list_item_widget.dart';

class RoomManagerPage extends StatefulWidget {
  @override
  _RoomManagerPageState createState() => _RoomManagerPageState();
}

class _RoomManagerPageState extends State<RoomManagerPage> {
  List<RoomListItemData> availableDataList = [];

  _getData()  async{
    var auth = ScopedModelHelper.getModel<AuthModel>(context);
    if(auth.isLogin) return;
    var token = auth.toString();
    String url = '/user/House';
    var res = await DioHttp.of(context).get(url, null, token);
    var resMap = json.decode(res.toString());
    List listMap = resMap['body'];

    var dataList =
        listMap.map((json) => RoomListItemData.fromJson(json)).toList();

    setState(() {
      availableDataList = dataList;
    });

  }

  @override
  void initState() {
    Timer.run(_getData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: new CommonFloatActionButton('发布房源',(){
          var res = Navigator.of(context).pushNamed('roomAdd');
          res.then((v){
            if(v==true){
              _getData();
            }
          });
        }),
        appBar: AppBar(
          title: Text('房屋管理'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: '空置'),
              Tab(text: '已组'),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ListView(
              children: availableDataList.map((f) => RoomListItemWidget(f)).toList()),
          ListView(
              children: availableDataList.map((f) => RoomListItemWidget(f)).toList())
        ]),
      ),
    );
  }
}

