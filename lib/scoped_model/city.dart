import 'package:house_rental/models/general_type.dart';
import 'package:scoped_model/scoped_model.dart';

class CityModel extends Model {
  GeneralType _city;

  set city(GeneralType data) {
    _city = data;
    notifyListeners();
  }

  GeneralType get city {
    return _city;
  }
}
