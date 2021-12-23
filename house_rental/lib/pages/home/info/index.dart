import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/info/data.dart';

import 'item_widget.dart';

class Info extends StatelessWidget {
  final bool showTitle;
  final List<InfoItem> dataList;

  const Info({Key key, this.showTitle = false, this.dataList = infoData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          if(showTitle)
            Container(
              child: Text(
                '最新咨询',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
            ),
            Column(
                children: dataList
                    .map((item) => ItemWidget(item))
                    .toList(),
              )
        ],
      ),
    );
  }
}
