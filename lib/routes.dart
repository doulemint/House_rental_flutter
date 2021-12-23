import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/pages/home/index.dart';
import 'package:house_rental/pages/loading.dart';
import 'package:house_rental/pages/login.dart';
import 'package:house_rental/pages/not_found.dart';
import 'package:house_rental/pages/register.dart';
import 'package:house_rental/pages/room_add/index.dart';
import 'package:house_rental/pages/room_detail/index.dart';
import 'package:house_rental/pages/room_manage/index.dart';
import 'package:house_rental/utils/setting.dart';

import 'pages/community_picker.dart';

class Routes{
  static String home='/';
  static String login='/login';
  static String register='/register';
  static String roomDetail='/roomDetail/:roomId';
  static String setting='/setting';
  static String roomManager='/roomManage';
  static String roomAdd='/roomAdd';
  static String communityPicker = '/communityPicker';
  static String loading = '/loading';

  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return HomePage();
  });

  static Handler _loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return LoginPage();
  });

  static Handler _registerHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return RegisterPage();
  });

  static Handler _notfoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return NotFoundPage();
  });

  static Handler _roomDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return RoomDetailPage(roomId: params['roomId'][0],);
  });

  static Handler _settingHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return SettingPage();
  });

  static Handler _roomManagerHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return RoomManagerPage();
  });

  static Handler _roomAddHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return RoomAddPage();
  });

  static Handler _communityPickerHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return CommunityPickerPage();
  });

   static Handler _loadingHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params){
    return LoadingPage();
  });

  static void configureRoutes(Router  router){
    router.define(login, handler: _loginHandler);
    router.define(home, handler: _homeHandler);
    router.define(register, handler: _registerHandler);
    router.define(roomDetail, handler: _roomDetailHandler);
    router.define(setting, handler: _settingHandler);
    router.define(roomManager, handler: _roomManagerHandler);
    router.define(roomAdd, handler: _roomAddHandler);
    router.define(communityPicker, handler: _communityPickerHandler);
    router.define(loading, handler: _loadingHandler);
    router.notFoundHandler = _notfoundHandler;
  }

}