import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:para_new/Helpers/constants.dart';

import '../Helpers/colors.dart';
import '../Helpers/scroll.dart';
import '../Utils/auth.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController phonecont = new TextEditingController();
  Widget load = Text(
    'reset',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ).tr();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.BACKGROUND_COLOR,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
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
                          flex: 3,
                          child: Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                "images/LogoWithOutLetters.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'reset',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ).tr(context: context),
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: new TextFormField(
                              controller: phonecont,
                              obscureText: false,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: new InputDecoration(
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                hintText: 'phone'.tr(),
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                                contentPadding: const EdgeInsets.only(
                                    top: 10.0,
                                    right: 30.0,
                                    bottom: 10.0,
                                    left: 5.0),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    load = loadingIndicator;
                                  });
                                  if (phonecont.text == '') {
                                    setState(() {
                                      load = Text(
                                        'reset',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ).tr();
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Container(
                                                height: 100,
                                                child: Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      'no creds',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ).tr(context: context)
                                                  ],
                                                ))),
                                          );
                                        });
                                  } else {
                                    DatabaseHelper()
                                        .resetPass(phone: phonecont.text)
                                        .then((res) {
                                      if (res.containsKey('errors')) {
                                        setState(() {
                                          load = Text(
                                            'reset',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ).tr();
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                    height: 100,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          'auth failed',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ).tr(context: context)
                                                      ],
                                                    ))),
                                              );
                                            });
                                      } else {
                                        setState(() {
                                          load = Text(
                                            'reset',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ).tr();
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                    height: 100,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          'pass reset',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ).tr(context: context)
                                                      ],
                                                    ))),
                                              );
                                            });
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: UIColors.PRIMARY_COLOR,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Center(child: load),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
