import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:house_rental/scoped_model/auth.dart';
import 'package:house_rental/scoped_model/city.dart';
import 'package:house_rental/scoped_model/room_filter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:house_rental/routes.dart';

class Application extends StatelessWidget {

  const Application({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    Router router = Router ();
    Routes.configureRoutes(router);
    return  
      ScopedModel<CityModel>(
    model: CityModel(),
    child:ScopedModel<AuthModel>(
    model: AuthModel(),
    child:ScopedModel<FilterBarModel>(
      model: FilterBarModel(),
      child:MaterialApp(
      // home: LoginPage(),
      theme: ThemeData(primaryColor: Colors.green),
      onGenerateRoute: router.generator,
      initialRoute: Routes.loading,
    ))));
  }
}