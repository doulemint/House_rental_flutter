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

    //θΏεε€η
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
      CommonToast.showToast('γε€§ε°γδΈθ½δΈΊη©Ί');
      return;
    }
    if (stringIsNullOrEmpty(price)) {
      CommonToast.showToast('γη§ιγδΈθ½δΈΊη©Ί');
      return;
    }
    if (null == community) {
      CommonToast.showToast('γε°εΊγδΈθ½δΈΊη©Ί');
      return;
    }
    
    var imageString = uploadImages(images, context);
    //CommonToast.showToast(imageString);

    String url = '/user/houses';

    //εζ°
    Map<String, dynamic> params = {
      "title": titleController.text,
      "description": descrController.text,
      "price": price,
      "size": size,
      "oriented": orientedList[oritType].id,
      "roomType": roomTypeList[roomType].id,
      "floor": floorList[floorType].id,
      "community": community.id,
      "houseImg": imageString, //ε€ζ‘δ»₯ ο½ εε²
      "supporting":
          applianceList.map((item) => item.title).join('|'), //ε€ζ‘δ»₯ ο½ εε²
    };
    var token = ScopedModelHelper.getModel<AuthModel>(context).token;

    var res = await DioHttp.of(context).post(url, params, token);
    var status = json.decode(res.toString())['status'];
    if (status.toString().startsWith('2')) {
      CommonToast.showToast('ζΏζΊεεΈζε');
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
        title: Text('ζΏζΊεεΈ'),
      ),
      body: ListView(
        children: <Widget>[
          CommonTitle('ζΏζΊδΏ‘ζ―'),
          CommonFormItem(
            label: 'ε°εΊ',
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
                            community?.name ?? 'θ―·ιζ©ε°εΊ',
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
            label: 'η§ι',
            hintText: 'θ―·θΎε₯η§ι',
            suffixText: 'ε/ζ',
            controller: priceController,
          ),
          CommonFormItem(
            label: 'ε€§ε°',
            hintText: 'θ―·θΎε₯ζΏε±ε€§ε°',
            suffixText: 'km',
            controller: sizeController,
          ),
          CommonRadioFormItem(
              label: 'η§θζΉεΌ',
              options: ['εη§', 'ζ΄η§'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  rentType = index;
                });
              }),
          CommonRadioFormItem(
            label: 'θ£δΏ?',
            options: ['η²Ύθ£', 'η?θ£'],
            value: decorType,
            onChange: (index) {
              setState(() {
                decorType = index;
              });
            },
          ),
          if(roomTypeList.length > 0)
          CommonSelectFormItem(
              label: 'ζ·ε',
              options: roomTypeList.map((item)=>item.name).toList(),//['δΈε?€', 'δΊε?€', 'δΈε?€', 'εε?€'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  roomType = index;
                });
              }),
          if(floorList.length > 0)
          CommonSelectFormItem(
              label: 'ζ₯Όε±',
              options: floorList.map((item)=>item.name).toList(),//['ι«ζ₯Όε±', 'δΈ­ζ₯Όε±', 'δ½ζ₯Όε±'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  floorType = index;
                });
              }),
          if(orientedList.length > 0)
          CommonSelectFormItem(
              label: 'ζε',
              options: orientedList.map((item)=>item.name).toList(),//['δΈ', 'θ₯Ώ', 'ε', 'ε'],
              value: rentType,
              onChange: (index) {
                setState(() {
                  oritType = index;
                });
              }),
          CommonTitle('ζΏζΊεΎε'),
          CommonImagePicker(onChange: (List<File> files) {
            setState(() {
              images = files;
            });
          }),
          CommonTitle('ζΏζΊζ ι’'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: titleController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText:  'θ―·θΎε₯ζ ι’οΌδΎε¦οΌζ΄η»οΌε°εΊε 2ε?€ 2000εοΌ'),
            ),
          ),
          CommonTitle('ζΏζΊιη½?'),
          RoomAppliance(
            onChange: (data){
              applianceList=data;
            },
          ),
          CommonTitle('ζΏζΊζθΏ°'),
            Container(
              margin: EdgeInsets.only(bottom:100.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: descrController,
              maxLines: 10,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'θ―·θΎε₯ζΏε±ζθΏ°δΏ‘ζ―'),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new CommonFloatActionButton('ζδΊ€', _submit),
    );
  }
}


