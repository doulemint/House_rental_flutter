

import 'models/general_type.dart';

class Config {
  static const CommonIcon = 'CommonIcon';
  static const PROXY_IP = '192.168.0.100';

/// 代理服务端口
  static const PROXY_PORT = 8001;
  static const BaseUrl = 'http://api-hookuprent-web.itheima.net'; //'http://192.168.0.100:8009'; ///rentHouse
  static List<GeneralType> availableCitys = [
    GeneralType('北京', 'AREA|88cff55c-aaa4-e2e0'),
    GeneralType('上海', 'AREA|dbf46d32-7e76-1196'),
    GeneralType('深圳', 'AREA|a6649a11-be98-b150'),
    GeneralType('广州', 'AREA|e4940177-c04c-383d'),
  ];
}
