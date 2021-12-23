import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/info/index.dart';
import 'package:house_rental/widgets/search_bar/index.dart';

class TabInfo extends StatelessWidget {
  // final InfoItem data;

  // const _TabInfoState(this.data,{Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SearchBar(
        onSearch: (){Navigator.of(context).pushNamed('search');},
      ),
      backgroundColor: Colors.white,),
      body: ListView(children: <Widget>[
        Padding(padding: EdgeInsets.only(top:10.0),),
         Info(showTitle: false),
      ],)
    );
  }
}
