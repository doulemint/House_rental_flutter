import 'package:flutter/material.dart';
import 'package:house_rental/config.dart';
import 'package:house_rental/models/room_list_item_data.dart';
// import 'package:house_rental/pages/home/tab_search/dataList.dart';
// import 'package:house_rental/models/room_list_item_data.dart';

import 'common_image.dart';
import 'common_tag.dart';

class RoomListItemWidget extends StatelessWidget {
  final RoomListItemData data;

  const RoomListItemWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = data.imageUri.startsWith('http')?data.imageUri:Config.BaseUrl+data.imageUri;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('roomDetail/${data.id}');
      },
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(children: <Widget>[
          CommonImage(
            imageUrl,
            width: 132.5,
            height: 100.0,
          ),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black)),
              Text(data.subTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
              Wrap(children: data.tags.map((f) => CommonTag(f)).toList()),
              Text('${data.price} 元/月',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.orange))
            ],
          ))
        ]),
      ),
    );
  }
}
