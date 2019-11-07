import 'package:flutter/material.dart';

Widget buildLoading(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.amber),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          "Loading...",
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025),
        ),
      ],
    ),
  );
}
