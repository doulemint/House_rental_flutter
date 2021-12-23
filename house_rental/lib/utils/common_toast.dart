import 'package:fluttertoast/fluttertoast.dart';

class CommonToast{
  static showToast(msg){
    Fluttertoast.showToast(msg: msg,
    gravity:ToastGravity.CENTER);
  }
}