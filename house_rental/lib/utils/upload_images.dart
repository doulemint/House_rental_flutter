import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';

import 'dio_http.dart';

Future<String> uploadImages(List<File> files, BuildContext context) async {
  if(null==files) return Future.value('');
  if(0==files.length) return Future.value('');

  var token = ScopedModelHelper.getModel<AuthModel>(context).token;
  var formData = FormData();
  formData.add("file", files.map((file)=>UploadFileInfo(file,'picture.jpg')).toList());

  String url = '/houses/image';

  try {
//发送请求，处理返回
    var res = await DioHttp.of(context).postFormData(url, formData, token);
    var data = json.decode(res.toString())['body'];
    String images = List<String>.from(data).join(' | ');

    return Future.value(images);
  } catch (err) {
    print(err);
  }
  return Future.value(null);
}