import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

void showInSnackBar(String value) {
  scaffoldKey.currentState.hideCurrentSnackBar();

  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[300],
      content: Text(
        value
      )
    )
  );
}