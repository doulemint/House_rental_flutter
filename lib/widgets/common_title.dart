import 'package:flutter/material.dart';

class CommonTitle extends StatelessWidget {

  final String title;

  const CommonTitle(this.title,{Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left:10.0),
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 18.0)),
    );
  }
}