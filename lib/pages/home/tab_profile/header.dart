import 'package:flutter/material.dart';
import 'package:house_rental/config.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/utils/scoped_model_helper.dart';

var loginRegisterStyle = TextStyle(fontSize: 20.0, color: Colors.white);

class TabHead extends StatelessWidget {
  Widget _notLoginBuilder(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 20.0),
      height: 95.0,
      decoration: BoxDecoration(color: Colors.green),
      child: Row(children: <Widget>[
        Container(
          height: 65.0,
          width: 65.0,
          margin: EdgeInsets.only(right: 15.0),
          child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://tva1.sinaimg.cn/large/006y8mN6ly1g6tbgbqv2nj30i20i2wen.jpg")),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 6.0)),
          Row(children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('login');
                },
                child: Text(
                  '登陆',
                  style: loginRegisterStyle,
                )),
            Text('/', style: loginRegisterStyle),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('register');
                },
                child: Text('注册', style: loginRegisterStyle)),
          ]),
          Text('登陆后体验更多', style: TextStyle(color: Colors.white))
        ])
      ]),
    );
  }

  Widget _loginBuilder(BuildContext context) {
    var userInfo = ScopedModelHelper.getModel<AuthModel>(context).userInfo;

    String userName = userInfo?.nickname ??'已登录用户名';
    String userImage = userInfo?.avatar ??
        "https://tva1.sinaimg.cn/large/006y8mN6ly1g6tbnovh8jj30hr0hrq3l.jpg";
    if(!userImage.startsWith('http')){
      userImage = Config.BaseUrl + userImage;
    }
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 20.0),
      height: 95.0,
      decoration: BoxDecoration(color: Colors.green),
      child: Row(children: <Widget>[
        Container(
          height: 65.0,
          width: 65.0,
          margin: EdgeInsets.only(right: 15.0),
          child: CircleAvatar(backgroundImage: NetworkImage(userImage)),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 6.0)),
          Text(userName, style: loginRegisterStyle),
          Text('查看编辑个人资料', style: TextStyle(color: Colors.white))
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = ScopedModelHelper.getModel<AuthModel>(context).isLogin;
    return isLogin ? _loginBuilder(context) : _notLoginBuilder(context);
  }
}
