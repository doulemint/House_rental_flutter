import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/info/index.dart';
import 'package:house_rental/pages/home/tab_profile/header.dart';

import 'advertisement.dart';
import 'function_button.dart';

class TabProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('我的'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('setting');
            },
          )
        ],
      ),
      body: ListView(children:<Widget>[
        TabHead(),
        FunctionButton(),
        Advertisement(),
        Info(showTitle: true,),
      ]),
    );
  }
}
