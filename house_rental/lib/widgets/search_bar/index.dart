import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/config.dart';
import 'package:house_rental/models/general_type.dart';
import 'package:house_rental/scoped_model/city.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/utils/store.dart';
import 'package:house_rental/widgets/common_image.dart';

class SearchBar extends StatefulWidget {
  final bool showLocation;
  final Function goBackCallback;
  final String inputValue;
  final String defaultInputValue;
  final Function onCancel;
  final bool showMap;
  final Function onSearch;
  final ValueChanged<String> onSearchSubmit;

  const SearchBar(
      {Key key,
      this.showLocation,
      this.goBackCallback,
      this.inputValue='',
      this.defaultInputValue='请输入搜索词',
      this.onCancel,
      this.showMap,
      this.onSearch,
      this.onSearchSubmit})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchWord = '';
  TextEditingController _controller;
  FocusNode _focus;
  Function _onClean(){
    setState(() {
      _controller.clear();
      _searchWord='';
    }); 
  }

  _saveCity(GeneralType city) async{
    if(city == null) return;
    ScopedModelHelper.getModel<CityModel>(context).city = city;
    var store = await Store.getInstance();
    var cityString = json.encode(city.toJson());
    store.setString(StoreKeys.city, cityString);
  }

  _changeLocation() async{
    var result = await CityPickers.showCitiesSelector(context: context, theme: ThemeData(primaryColor: Colors.green));

    String cityName = result?.cityName;
    if(null==cityName) return ;

    var city = Config.availableCitys.firstWhere((city)=>cityName.startsWith(city.name), orElse: (){
      CommonToast.showToast('该城市暂未开通');
      return null;
    });

    if(city==null) return ;
    _saveCity(city);
  }

  _getCity() async{
    var store = await Store.getInstance();
    var cityString = await store.getString(StoreKeys.city);
    if(null == cityString) return;
    var city = GeneralType.fromJson(json.decode(cityString));
    ScopedModelHelper.getModel<CityModel>(context).city = city;
  }

  @override
  void initState() {
    _focus = FocusNode();
    _controller = TextEditingController(text: widget.inputValue);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var city = ScopedModelHelper.getModel<CityModel>(context).city;
    if(city==null){
      city = Config.availableCitys.first;
      _getCity();
    }
    return Container(
      height: 35.0,
      child: Row(
        children: <Widget>[
          if (widget.showLocation != null)
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  _changeLocation();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  Icon(Icons.room, color: Colors.white, size: 16),
                  Padding(padding: EdgeInsets.only(right:5.0),),
                  Text(
                    city.name,
                   // '北京',
                    style: TextStyle(color: Colors.black,fontSize: 14.0),
                  ),
                ]),
              ),
            ),
          if (widget.goBackCallback != null)
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                  onTap: widget.goBackCallback,
                  child: Icon(Icons.chevron_left,
                      color: Colors.black87, size: 16)),
            ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(17.0)),
            margin: EdgeInsets.only(right: 10.0),
            child: TextField(
              focusNode: _focus,
              controller: _controller,
              style: TextStyle(fontSize: 14.0),
              onChanged: (String value){
                setState(() {
                  _searchWord=value;
                });
              },
              onTap: (){
                if(null==widget.onSearchSubmit){
                  _focus.unfocus();
                }
                if(widget.onSearch != null) widget.onSearch();
                },
              onSubmitted: widget.onSearchSubmit,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: '请输入搜索词',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14.0),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:8.0,left: -10.0),
                  icon: Padding(
                    padding: EdgeInsets.only(top: 6.0,left:8.0),
                                      child: Icon(
                      Icons.search,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      _onClean();
                    },
                    child: Icon(
                      Icons.cancel,
                      size: 18.0,
                      color: _searchWord==''? Colors.grey[200]:Colors.grey,
                    ),
                  )),
            ),
          )),
          if (widget.onCancel != null )
            Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                    onTap: widget.onCancel,
                    child: Text('取消',
                        style:
                            TextStyle(color: Colors.black, fontSize: 14.0)))),
          if (widget.showLocation != null)
            CommonImage('static\\icons\\widget_search_bar_map.png'),
        ],
      ),
    );
  }
}
