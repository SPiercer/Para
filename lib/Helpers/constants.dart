import 'package:flutter/material.dart';


String serverUrl = "http://test.paraksa.com";
Widget loadingIndicator = CircularProgressIndicator();
void showInSnackBar(
    String value, BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey,
    {Color color}) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: color == null ? Colors.red : color,
    duration: Duration(seconds: 3),
  ));
}
