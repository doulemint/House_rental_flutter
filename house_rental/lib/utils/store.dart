import 'package:shared_preferences/shared_preferences.dart';

enum StoreKeys {
    token,
    city,

}
class Store{
  static StoreKeys storeKeys;
  final SharedPreferences _store;

  //实例化方法
  static Future<Store> getInstance() async{
    //初始化
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Store._internal(prefs);
      }
    
   //初始化store
  Store._internal(this._store);
  getString(StoreKeys key) async {
    return _store.get(key.toString());
  }

  setString(StoreKeys key, String value) async {
    return _store.setString(key.toString(), value);
  }

  getStringList(StoreKeys key) async {
      return _store.getStringList(key.toString());
    }
  
    setStringList(StoreKeys key, List<String> value) async {
      return _store.setStringList(key.toString(), value);
    }
  }
  
