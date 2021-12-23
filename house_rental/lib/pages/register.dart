import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rental/utils/common_toast.dart';
import 'package:house_rental/utils/dio_http.dart';
import 'package:house_rental/utils/string_is_null_or_empty.dart';
// import 'package:house_rental/widgets/page_content.dart';
import 'package:dio/dio.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassssword = false;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();

  _RegisterHandler() async{
    var username = usernameController.text;
    var psw = passwordController.text;
    var rpsw = repeatPasswordController.text;
    if(psw!=rpsw){
      CommonToast.showToast('两次输入的密码不一致');
      return ;
    }
    if(stringIsNullOrEmpty(username)||stringIsNullOrEmpty(psw)){
       CommonToast.showToast('密码或者用户名不能为空');
      return ;
    }
    const url = '/user/registered';
    var params = {"username": username, "password": psw};
    
    var res = await DioHttp.of(context).post(url, params);
    var resString = json.decode(res.toString());
    // print(resString.toString());

    String status = resString['status'].toString();
    String description = resString['description'] ?? '内部错误';
    CommonToast.showToast(description+status.toString());
    if (status.toString().startsWith('2')) {
      Navigator.of(context).pushReplacementNamed('login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: Text('登陆'),
        title: Text('注册'),
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
              controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
              ),
            ),
             Padding(padding: EdgeInsets.all(10),),
            TextField(
              controller: repeatPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: '确认密码',
                    hintText: '请再次输入密码',
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            RaisedButton(
                onPressed: () {
                  _RegisterHandler();
                },
                color: Colors.greenAccent,
                child: Text('注册',style: TextStyle(color: Colors.white),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('已有账号，'),
                FlatButton(onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                }, child: Text('去登陆~'),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
