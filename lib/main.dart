import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteostation/widgets/build_column_with_data.dart';
import 'package:meteostation/widgets/build_initial_input.dart';
import 'package:meteostation/widgets/build_loading.dart';
import 'bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
}
