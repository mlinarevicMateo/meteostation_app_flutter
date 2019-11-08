import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  double temperature;
  double humidity;
  double pressure;
  double windSpeed;
  String windDirection;
  String date;
  String time;
  bool isDay;

  Weather(
      {@required this.cityName,
      @required this.temperature,
      @required this.humidity,
      @required this.pressure,
      @required this.windSpeed,
      @required this.windDirection,
      @required this.time,
      @required this.date,
      @required this.isDay})
      : super([
          cityName,
          temperature,
          humidity,
          pressure,
          windSpeed,
          windDirection,
          time,
          date,
          isDay,
        ]);

  Weather.fromMap(Map<String, dynamic> weather, this.cityName) {
    this.temperature = double.parse(weather['temperature']);
    this.humidity = double.parse(weather['humidity']);
    this.pressure = double.parse(weather['pressure']);
    this.windSpeed = double.parse(weather['windSpeed']);
    this.windDirection = weather['windDirection'].toString();
    this.time = _parseTimeFromTimestamp(weather['timestamp'].toString());
    this.date = _parseDateFromTimestamp(weather['timestamp'].toString());
    this.isDay = _sunriseSunsetFormatter(
        weather['sunrise'], weather['sunset'], weather['timestamp'].toString());
  }

  bool _sunriseSunsetFormatter(
      String sunrise, String sunset, String timestamp) {
    var formatter = new DateFormat('yyyy-MM-dd');

    var currentDate = formatter.format(DateTime.now());

    DateTime sunriseParsed = DateTime.parse(
        currentDate + " " + sunrise.toString());

    DateTime sunsetParsed = DateTime.parse(
        currentDate + " " + sunset.toString());

    DateTime time =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);

    if (time.hour > sunriseParsed.hour && time.hour < sunsetParsed.hour) {
      return true;
    }
    return false;
  }

  String _parseTimeFromTimestamp(String timestamp) {
    var formatter = new DateFormat('Hm');
    String time = formatter.format(
        DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000));
    return time;
  }

  String _parseDateFromTimestamp(String timestamp) {
    var formatter = new DateFormat('dd MMM yyyy');
    return formatter.format(
        DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000));
  }
}
