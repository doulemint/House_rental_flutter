//结果数据类型

import 'package:house_rental/models/general_type.dart';

class FilterBarResult {
  final String areaId;
  final String priceId;
  final String rentTypeId;
  final List<String> moreIds;

  FilterBarResult({this.areaId, this.priceId, this.rentTypeId, this.moreIds});
}
// class GeneralType{
//   final String name;
//   final String id;

//   GeneralType(this.name, this.id);
// }

// List<GeneralType> areaList =[
//   GeneralType('区域1','11'),
//   GeneralType('区域2','22'),
// ];

// List<GeneralType> priceList =[
//   GeneralType('价格1','11'),
//   GeneralType('价格2','22'),
// ];

// List<GeneralType> rentList =[
//   GeneralType('出租类型1','11'),
//   GeneralType('出租类型2','22'),
// ];

// List<GeneralType> orientList =[
//   GeneralType('方向1','11'),
//   GeneralType('方向2','22'),
// ];

// List<GeneralType> floorList =[
//   GeneralType('楼层1','11'),
//   GeneralType('楼层2','22'),
// ];