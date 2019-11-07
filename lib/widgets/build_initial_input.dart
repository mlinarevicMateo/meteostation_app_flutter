import 'package:flutter/material.dart';
import 'package:meteostation/widgets/city_input_field.dart';

Widget buildInitialInput(BuildContext context, bool error) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      CityInputField(
        error: error,
      ),
    ],
  );
}
