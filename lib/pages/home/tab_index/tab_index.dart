import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/info/index.dart';
import 'package:house_rental/widgets/common_swipper.dart';
import 'package:house_rental/widgets/search_bar/index.dart';

import 'index_navigator.dart';
import 'index_recommond.dart';
// import 'flutter_';


class TabIndexPage extends StatefulWidget {
  const TabIndexPage({Key key}) : super(key: key);

  @override
  _TabIndexPageState createState() => _TabIndexPageState();
}

class _TabIndexPageState extends State<TabIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SearchBar(
        showLocation:true,
        showMap:true,
        onSearch:(){
          Navigator.of(context).pushNamed('search');
        }
      ),),
      body: ListView(children: <Widget>[
        CommonSwiper(),
        IndexNavigator(),
        IndexRecommond(),
        Info(showTitle:true),
        Text("here are content.")
      ],)
    );
  }
}