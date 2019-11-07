import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meteostation/model/weather.dart';
import 'package:meteostation/rest_data_source.dart';

import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherInitial(error: false);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeather) {
      yield WeatherLoading();

      final weather = await _fetchWeatherFromApi(event.cityName);

      if (weather == null) {
        yield WeatherInitial(error: true);
        return;
      }

      yield WeatherLoaded(weather: weather);
    }
  }

  Future<Weather> _fetchWeatherFromApi(String cityName) async {
    RestDataSource api = new RestDataSource();

    try {
      Weather res = await api.fetchWeather(cityName);
      print(res.cityName);
      return res;
    } on Exception {
      return null;
    }
  }
}
