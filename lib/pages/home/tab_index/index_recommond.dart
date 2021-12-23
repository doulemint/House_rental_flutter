import 'package:flutter/material.dart';

import 'index_recommond_data.dart';
import 'index_recommond_item_widget.dart';

class IndexRecommond extends StatelessWidget {
  final List<IndexRecommendItem> dataList;
  //组件默认值是常量
  const IndexRecommond({Key key, this.dataList = indexRecommendData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color(0x08000000)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('房屋推荐',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
              Text('更多', style: TextStyle(color: Colors.black54)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children:
                  dataList.map((e) => IndexRecommandItemWidget(e)).toList())
        ],
      ),
    );
  }
}
