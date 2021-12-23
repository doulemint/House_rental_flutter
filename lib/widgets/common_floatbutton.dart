import 'package:flutter/material.dart';

class CommonFloatActionButton extends StatelessWidget{
  final String title;
  final Function onTap;

  const CommonFloatActionButton(this.title, this.onTap,{Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              if(onTap!=null){
                onTap();
              }
              // Navigator.of(context).pushNamed('roomAdd');
            },
            child: Container(
              margin: EdgeInsets.all(20.0),
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              )),
            ));
  }
}