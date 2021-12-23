import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:house_rental/models/community.dart';
import 'package:house_rental/models/general_type.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/utils/string_is_null_or_empty.dart';
import 'package:house_rental/utils/upload_images.dart';
import 'package:house_rental/widgets/common_floatbutton.dart';
import 'package:house_rental/widgets/common_form_item.dart';
import 'package:house_rental/widgets/common_image_picker.dart';
import 'package:house_rental/widgets/common_radio_form_item.dart';
import 'package:house_rental/widgets/common_select_form_item.dart';
import 'package:house_rental/widgets/common_title.dart';
import 'package:house_rental/widgets/room_appliance.dart';

import 'package:house_rental/scoped_model/auth.dart';

class RoomAddPage extends StatefulWidget {
  @override
  _RoomAddPageState createState() => _RoomAddPageState();
}

class _RoomAddPageState extends State<RoomAddPage> {

  List<GeneralType> floorList = [];
  List<GeneralType> orientedList = [];
  List<GeneralType> roomTypeList = [];
  
  int rentType = 0;
  int floorType = 0;
  int decorType = 0;
  int oritType = 0;
  int roomType = 0;
  List<File> images = [];

  Community community;

  List<RoomApplianceItem> applianceList=[];

  var titleController=TextEditingController();
  var descrController=TextEditingController();

  var sizeController=TextEditingController();
  var priceController=TextEditingController();

  _getParams() async{
    String url = '/houses/params';

    //返回处理
    var res = await DioHttp.of(context).get(url);

    var data = json.decode(res.toString())['body'];
    List<GeneralType> floorList = List<GeneralType>.from(
        data['floor'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> orientedList = List<GeneralType>.from(
        data['oriented'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> roomTypeList = List<GeneralType>.from(
        data['roomType'].map((item) => GeneralType.fromJson(item)).toList());

    setState(() {
      this.floorList = floorList;
      this.orientedList = orientedList;
      this.roomTypeList = roomTypeList;
    });
  }

  @override
  void initState() {
    Timer.run(_getParams);
    super.initState();
  }

  _submit() async{
    var size = sizeController.text;
    var price = priceController.text;

    if (stringIsNullOrEmpty(size)) {
      CommonToast.showToast('【大小】不能为空');
      return;
    }
    if (stringIsNullOrEmpty(price)) {
      CommonToast.showToast('【租金】不能为空');
      return;
    }
    if (null == community) {
      CommonToast.showToast('【小区】不能为空');
      return;
    }
    
    var imageString = uploadImages(images, context);
    //CommonToast.showToast(imageString);

    String url = '/user/houses';

    //参数
    Map<String, dynamic> params = {
      "title": titleController.text,
      "description": descrController.text,
      "price": price,
      "size": size,
      "oriented": orientedList[oritType].id,
      "roomType": roomTypeList[roomType].id,
      "floor": floorList[floorType].id,
      "community": community.id,
      "houseImg": imageString, //多条以 ｜ 分割
      "supporting":
          applianceList.map((item) => item.title).join('|'), //多条以 ｜ 分割
    };
    var token = ScopedModelHelper.getModel<AuthModel>(context).token;

    var res = await DioHttp.of(context).post(url, params, token);
    var status = json.decode(res.toString())['status'];
    if (status.toString().startsWith('2')) {
      CommonToast.showToast('房源发布成功');
      bool isSubmitted = true;
      Navigator.of(context).pop(isSubmitted);
    } else {
      var description = json.decode(res.toString())['description'];
      CommonToast.showToast(description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('房源发布'),
      ),
      body: ListView(
        children: <Widget>[
          CommonTitle('房源信息'),
          CommonFormItem(
            label: '小区',
            contenetBuild: (context) {
              return Expanded(
                child: GestureDetector(
                    onTap: () {
                      var result = Navigator.of(context).pushNamed('communityPicker');
                      result.then((value){
                        if(value!=null){
                          setState(() {
                            community = value;
                          });
                        }
                      });
                    },
                    child: Container(
                      height: 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            community?.name ?? '请选择小区',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    )),
              );
            },
          ),
          CommonFormItem(
            label: '租金',
            hintText: '请输入租金',
            suffixText: '元/月',
            controller: priceController,
          ),
          CommonFormItem(
            label: '大小',
            hintText: '请输入房屋大小',
            suffixText: 'km',
            controller: sizeController,
          ),
          CommonRadioFormItem(
              label: '租聘方式',
              options: ['合租', '整租'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  rentType = index;
                });
              }),
          CommonRadioFormItem(
            label: '装修',
            options: ['精装', '简装'],
            value: decorType,
            onChange: (index) {
              setState(() {
                decorType = index;
              });
            },
          ),
          if(roomTypeList.length > 0)
          CommonSelectFormItem(
              label: '户型',
              options: roomTypeList.map((item)=>item.name).toList(),//['一室', '二室', '三室', '四室'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  roomType = index;
                });
              }),
          if(floorList.length > 0)
          CommonSelectFormItem(
              label: '楼层',
              options: floorList.map((item)=>item.name).toList(),//['高楼层', '中楼层', '低楼层'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  floorType = index;
                });
              }),
          if(orientedList.length > 0)
          CommonSelectFormItem(
              label: '朝向',
              options: orientedList.map((item)=>item.name).toList(),//['东', '西', '南', '北'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  oritType = index;
                });
              }),
          CommonTitle('房源图像'),
          CommonImagePicker(onChange: (List<File> files) {
            setState(() {
              images = files;
            });
          }),
          CommonTitle('房源标题'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: titleController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText:  '请输入标题（例如：整组，小区名 2室 2000元）'),
            ),
          ),
          CommonTitle('房源配置'),
          RoomAppliance(
            onChange: (data){
              applianceList=data;
            },
          ),
          CommonTitle('房源描述'),
            Container(
              margin: EdgeInsets.only(bottom:100.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: descrController,
              maxLines: 10,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '请输入房屋描述信息'),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new CommonFloatActionButton('提交', _submit),
    );
  }
}


