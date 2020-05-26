import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:para_new/Helpers/constants.dart';

import '../Auth/login.dart';
import '../Helpers/colors.dart';
import '../Utils/auth.dart';

class RegisterSecondStep extends StatefulWidget {
  final int userid;
  RegisterSecondStep({this.userid});

  @override
  _RegisterSecondStepState createState() {
    return _RegisterSecondStepState();
  }
}

class _RegisterSecondStepState extends State<RegisterSecondStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/RegisterBackGround.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ).tr(context: context)),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              "images/RegisterIconPhone.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 3,
              ),
              Flexible(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "type pin",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: UIColors.PRIMARY_COLOR),
                                ).tr(context: context),
                              ],
                            ),
                          ),
                          flex: 5,
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: UIColors.PRIMARY_COLOR)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: UIColors.PRIMARY_COLOR)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                          color: UIColors.PRIMARY_COLOR),
                                    )),
                                maxLength: 4,
                                onSubmitted: (String pin) async {
                                  int pinInt = int.parse(pin);

                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: <Widget>[
                                              Center(
                                                child: loadingIndicator,
                                              ),
                                              Text('Please Wait')
                                            ],
                                          ));
                                  var response = await DatabaseHelper()
                                      .verify(pinInt, widget.userid);
                                  if (response['code'] == 404) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actions: <Widget>[
                                            Center(
                                              child: Text(
                                                'wrong pin'.tr(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            RaisedButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actions: <Widget>[
                                            RaisedButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login()));
                                              },
                                            )
                                          ],
                                          title: Center(
                                            child: Text(
                                              'verified'.tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                  flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
