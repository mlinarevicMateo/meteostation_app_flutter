import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteostation/widgets/build_initial_input.dart';
import 'package:meteostation/widgets/build_loading.dart';
import 'package:meteostation/widgets/city_input_field.dart';

import 'MeteoIcons.dart';
import 'bloc/bloc.dart';
import 'model/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSRE Meteostation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        builder: (context) => WeatherBloc(),
        child: WeatherPageChild(),
      ),
    );
  }
}

class WeatherPageChild extends StatelessWidget {
  const WeatherPageChild({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromARGB(255, 52, 63, 75),
      alignment: Alignment.center,
      child: BlocListener(
        bloc: BlocProvider.of<WeatherBloc>(context),
        listener: (BuildContext context, WeatherState state) {
          if (state is WeatherInitial && state.error) {
            final errorSnackBar = SnackBar(
              content: Text(
                  'Place that you searched does not exist. Please try again.'),
              elevation: 0.0,
            );
            Scaffold.of(context).showSnackBar(errorSnackBar);
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<WeatherBloc>(context),
          builder: (BuildContext context, WeatherState state) {
            if (state is WeatherInitial) {
              return buildInitialInput(context, state.error);
            } else if (state is WeatherLoading) {
              return buildLoading(context);
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(state.weather, context);
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildColumnWithData(Weather weather, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CityInputField(
              error: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "${weather.cityName}",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, fontFamily: 'Lato'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "${weather.temperature.toStringAsFixed(1)} °C",
                  style: TextStyle(
                      fontSize: 80, color: Colors.white, fontFamily: 'Lato'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 119, 179, 212),
                    child: Center(
                      child: Icon(
                        MeteoIcons.drop,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    "${weather.humidity.toStringAsFixed(2)} %",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 119, 179, 212),
                    child: Center(
                      child: Icon(
                        MeteoIcons.gauge,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    "${weather.pressure.toStringAsFixed(2)} hPa",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 119, 179, 212),
                    child: Center(
                      child: Icon(
                        MeteoIcons.wind,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    "${weather.windSpeed.toStringAsFixed(1)} km/h",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 119, 179, 212),
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            MeteoIcons.ws,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  title: Text(
                    "${weather.windDirection}",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  child: Center(
                    child: weather.isDay
                        ? Icon(
                            Icons.brightness_1,
                            color: Colors.yellow,
                            size: 140.0,
                          )
                        : Icon(
                            Icons.brightness_3,
                            color: Colors.grey,
                            size: 140.0,
                          ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      weather.time,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 50.0,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  child: Center(
                    child: Text(
                      weather.date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
