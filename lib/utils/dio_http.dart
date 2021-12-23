import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:house_rental/config.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';

import '../routes.dart';

class DioHttp{
  Dio _client;
  BuildContext context;

  get json => null;

  static DioHttp of(context){
    return DioHttp._internal(context);
  }

  DioHttp._internal(BuildContext context){
    if(_client==null||context!=this.context){
      this.context = context;
      var options = BaseOptions(baseUrl: Config.BaseUrl,
      connectTimeout: 1000*10,
      receiveTimeout: 1000*3,
      extra: {'context':context});

      Interceptor interceptor = InterceptorsWrapper(onResponse: (Response res) {

        if(null==res) return res;
        var status =json.decode(res.toString())['status'];

        if(status==404){
          CommonToast.showToast('接口地址错误！当前接口: ${res.request.path}');
          return res;
        }
        if(status.toString().startsWith('4')){
          ScopedModelHelper.getModel<AuthModel>(context).logout();
          
          if (ModalRoute.of(context).settings.name == Routes.loading) {
            return res;
          }
          
          CommonToast.showToast('登陆过期');
          Navigator.of(context).pushNamed(Routes.login);
          return res;
          
        }
        return res;
      });
    var client =Dio(options);
    this._client = client; 
    }
  }

  Future<Response<Map<String, dynamic>>> get(String path,
      [Map<String, dynamic> params, String token]) async {
    var options = Options(headers: {'Authorization': token});
    return await _client.get(path, queryParameters: params, options: options);
  }

  Future<Response<Map<String, dynamic>>> post(String path,
      [Map<String, dynamic> params, String token]) async {
    var options = Options(headers: {'Authorization': token});
    return await _client.post(path, queryParameters: params, options: options);
  }

  Future<Response<Map<String, dynamic>>> postFormData(String path,
      [Map<String, dynamic> params, String token]) async {
    var options = Options(
      contentType: ContentType.parse('multipart/form-data'),
      headers: {'Authorization': token});
    return await _client.post(path, data: params, options: options);
  }
}