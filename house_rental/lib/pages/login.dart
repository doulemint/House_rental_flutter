import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';
import 'package:house_rental/utils/store.dart';
import 'package:house_rental/utils/string_is_null_or_empty.dart';
// import 'package:house_rental/widgets/page_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassssword = false;

  var usernameController = TextEditingController();
  var pswController = TextEditingController();

  _loginHandle() async{
    var username = usernameController.text;
    var psw = pswController.text;

    if(stringIsNullOrEmpty(username)||stringIsNullOrEmpty(psw)){
      CommonToast.showToast('密码或者用户名不能为空');
      return ;
    }

    const url = '/jwt/token';
    var formData = FormData.from({"username": username, "password": psw});
    
    var res = await DioHttp.of(context).postFormData(url, formData);
    var resString = json.decode(res.toString());
    // print(resString.toString());

    String status = resString['status'].toString();
    String description = resString['description'] ?? '内部错误';
    CommonToast.showToast(description+status.toString());
    if (status.toString().startsWith('2')) {
      String token = resString['access_token'];

      Store store= await Store.getInstance();
      await store.setString(StoreKeys.token, token);

      ScopedModelHelper.getModel<AuthModel>(context).login(token,context);
      Timer(Duration(seconds: 1), (){
         Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: Text('登陆'),
        title: Text('登陆'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(30),
        child: ListView(  //convert column to listview to extend the height of screen
          children: <Widget>[
            TextField(
              controller: usernameController,
                decoration:
                    InputDecoration(labelText: '用户名', hintText: '请输入用户名')),
            Padding(padding: EdgeInsets.all(10),),
            TextField(
                controller: pswController,
                obscureText: !showPassssword,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    suffixIcon: IconButton(
                      icon: Icon(showPassssword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          showPassssword = !showPassssword;
                        });
                      },
                    ))),
            Padding(padding: EdgeInsets.all(10),),
            RaisedButton(
                onPressed: () {
                  //todo
                  _loginHandle();
                },
                color: Colors.greenAccent,
                child: Text('登陆',style: TextStyle(color: Colors.white),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('还没有账号，'),
                FlatButton(child: Text('去注册~'),onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
