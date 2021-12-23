import 'package:flutter/material.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('设置')),
      body: ListView(children: <Widget>[
        RaisedButton(onPressed: (){
          ScopedModelHelper.getModel<AuthModel>(context).logout();
          CommonToast.showToast("已经退出登陆");
        },
        child:Text('退出登陆',style: TextStyle(color: Colors.red),))
      ],),
    );
  }
}