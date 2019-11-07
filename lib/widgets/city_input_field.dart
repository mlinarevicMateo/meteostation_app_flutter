import 'package:flutter/material.dart';
import 'package:meteostation/widgets/city_input_textfield.dart';

class CityInputField extends StatelessWidget {
  final bool error;

  const CityInputField({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: CityInputTextField(
        error: error,
      ),
    );
  }
}
