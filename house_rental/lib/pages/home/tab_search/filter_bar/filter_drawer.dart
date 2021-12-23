import 'package:flutter/material.dart';
import 'package:house_rental/models/general_type.dart';
import 'package:house_rental/widgets/common_title.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/scoped_model/room_filter.dart';
import 'package:house_rental/pages/home/tab_search/filter_bar/data.dart';

class FilterDrawer extends StatelessWidget {
  
  // var =[];
  @override
  Widget build(BuildContext context) {
    var dataList = ScopedModelHelper.getModel<FilterBarModel>(context).dataList;
    var rentList = dataList['roomTypeList'];
    var orientList = dataList['orientedList'];
    var floorList = dataList['floorList'];

    // var selectedIds=['11'];
    var selectedIds=ScopedModelHelper.getModel<FilterBarModel>(context).selectedList.toList();

    _onChange(String val){
      ScopedModelHelper.getModel<FilterBarModel>(context).selectedListToggleItem(val);
    }
    return Drawer(
        child: SafeArea(
            child: ListView(
      children: <Widget>[
        CommonTitle('户型'),
        FilterDrawerItem(list:rentList,selectedIds: selectedIds,onChange: _onChange,),
        CommonTitle('朝向'),
        FilterDrawerItem(list:orientList,selectedIds: selectedIds,onChange: _onChange,),
        CommonTitle('楼层'),
        FilterDrawerItem(list:floorList,selectedIds: selectedIds,onChange: _onChange,),
      ],
    )));
  }
}

class FilterDrawerItem extends StatelessWidget {

  final List<GeneralType> list;
  final List<String> selectedIds;
  final ValueChanged<String> onChange;

  const FilterDrawerItem({Key key, this.list, this.selectedIds, this.onChange}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:10.0,right:10.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: list
            .map((item) {
              var isActivate = selectedIds.contains(item.id);
              return GestureDetector(
                  onTap: () {
                    if(onChange!=null) onChange(item.id);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 100.0,
                    height: 40.0,
                      decoration: BoxDecoration(
                        color: isActivate?Colors.green:Colors.white,
                          border:
                              Border.all(width: 1.0, color: Colors.green)),
                      child: Center(child: Text(item.name,style: TextStyle(color: isActivate?Colors.white:Colors.green),))),
                );}
                )
            .toList(),
      ),
    );
  }
}
