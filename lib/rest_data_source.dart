import 'dart:async';

import 'model/weather.dart';
import 'network_util.dart';

class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();

  static final BASE_URL = "https://enigmatic-forest-52909.herokuapp.com/";
  static final METEOSTATION_NAME = "meteostationdatabyname?name=";
  static final METEOSTATIONS = "meteostations";

  Future<Weather> fetchWeather(String meteostationName) async {
    return _netUtil
        .get(BASE_URL + METEOSTATION_NAME + meteostationName.toString())
        .then((dynamic res) {
      if (res.toString().length > 50) {
        return Weather.fromMap(res, meteostationName);
      }
      return null;
    });
  }
}
