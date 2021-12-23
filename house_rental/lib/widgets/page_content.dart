import 'package:flutter/material.dart';

import '../routes.dart';

class PageContent extends StatelessWidget {
  final String name;

  const PageContent({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("当前页面： $name"),
        ),
        body: ListView(
          children: <Widget>[
            FlatButton(
              child: Text(Routes.home),
              onPressed: () {
                Navigator.pushNamed(context, Routes.home);
              },
            ),
            FlatButton(
              child: Text(Routes.login),
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
              },
            ),
            FlatButton(
              child: Text("404"),
              onPressed: () {
                Navigator.pushNamed(context, '/124');
              },
            ),
            FlatButton(
              child: Text("房屋详情页"),
              onPressed: () {
                Navigator.pushNamed(context, '/room/222');
              },
            ),
          ],
        ));
  }
}
