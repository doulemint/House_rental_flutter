import 'package:flutter/material.dart';
import 'package:house_rental/widgets/common_image.dart';

import 'index_recommond_data.dart';

class IndexRecommandItemWidget extends StatelessWidget {

  final IndexRecommendItem data;

  const IndexRecommandItemWidget(this.data, {Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(data.navigateUri);
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: (MediaQuery.of(context).size.width-10.0*3)/2,
        height: 100.0,

        child: Row( 
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Column(children: <Widget>[
            Text(data.title),
            Text(data.subTitle)
          ],),
          CommonImage(data.imageUri)
        ],),
      ),
    );
  }
}