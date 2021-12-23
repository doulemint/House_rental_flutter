import 'package:flutter/material.dart';
import 'package:house_rental/widgets/common_image.dart';

import 'index_navigator_item.dart';

class IndexNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:6.0,bottom:6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: indexNavigatorItemList
            .map((item) => InkWell(
                  onTap: () {
                    item.onTap(context);
                  },
                  child: Column(children: <Widget>[
                    CommonImage(item.imageUri, width: 47.5),
                    Text(item.title)
                  ],),
                ))
            .toList(),
      ),
    );
  }
}
