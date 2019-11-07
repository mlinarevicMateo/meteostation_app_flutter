import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteostation/bloc/weather_bloc.dart';
import 'package:meteostation/bloc/weather_event.dart';

class CityInputTextField extends StatefulWidget {
  final bool error;

  const CityInputTextField({Key key, this.error}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CityInputTextFieldState();
}

class _CityInputTextFieldState extends State<CityInputTextField> {
  @override
  Widget build(BuildContext context) {
    final placeNameController = TextEditingController();

    return TextField(
      onSubmitted: submitCityName,
      textInputAction: TextInputAction.search,
      controller: placeNameController,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        hoverColor: Colors.white70,
        hintText: widget.error ? "Try again" : "Search places",
        errorText: widget.error ? "Place does not exist." : null,
        enabledBorder: outlineInputBorder(Colors.transparent),
        focusedBorder: outlineInputBorder(Colors.white30),
        errorBorder: outlineInputBorder(Colors.red),
        focusedErrorBorder: outlineInputBorder(Colors.red),
        hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
        prefixIcon: Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  void submitCityName(String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.dispatch(GetWeather(cityName));
  }

  dynamic outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.height / 2),
    );
  }
}
