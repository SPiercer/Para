import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Helpers/scroll.dart';
import '../Utils/auth.dart';
import 'verification.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DatabaseHelper instance = new DatabaseHelper();
  Widget load = Text(
    'register',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ).tr();
  TextEditingController namecont = new TextEditingController();
  TextEditingController phonecont = new TextEditingController();
  TextEditingController passcont = new TextEditingController();
  TextEditingController passConfcont = new TextEditingController();

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
                                "images/RegisterIcon.png",
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
                                'register',
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
                Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: new TextFormField(
                            obscureText: false,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: 'full name'.tr(),
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              contentPadding: const EdgeInsets.only(
                                  top: 10.0,
                                  right: 30.0,
                                  bottom: 10.0,
                                  left: 5.0),
                            ),
                            controller: namecont,
                          ),
                        ),
                      
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                            border: new Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                            border: new Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: new TextFormField(
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: 'password'.tr(),
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              contentPadding: const EdgeInsets.only(
                                  top: 10.0,
                                  right: 30.0,
                                  bottom: 10.0,
                                  left: 5.0),
                            ),
                            controller: passcont,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                            border: new Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: new TextFormField(
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: new InputDecoration(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: 'confirm password'.tr(),
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              contentPadding: const EdgeInsets.only(
                                  top: 10.0,
                                  right: 30.0,
                                  bottom: 10.0,
                                  left: 5.0),
                            ),
                            controller: passConfcont,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Container(
                            child: InkWell(
                              onTap: () async {
                                if (namecont.text != '' ||
                                    passcont.text != '' ||
                                    passConfcont.text != '') {
                                  setState(() {
                                    load = loadingIndicator;
                                  });
                                  if (passcont.text == passConfcont.text) {
                                    var response =
                                        await DatabaseHelper().regData(
                                      name: namecont.text,
                                      pass: passcont.text,
                                      passConfirm: passConfcont.text,
                                      phone: phonecont.text,
                                    );

                                    if (response.containsKey('errors')) {
                                      List<String> m = [];
                                      response['errors'].forEach((k, v) {
                                        m.add(v[0]);
                                      });
                                      
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            actions: <Widget>[
                                              Center(
                                                child: Text(
                                                  m.toString(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      setState(() {
                                        load = Text(
                                          'register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ).tr();
                                      });
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            actions: <Widget>[
                                              Center(
                                                child: Text(
                                                  'registered'.tr(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterSecondStep(
                                                    userid: response['user']
                                                        ['id'],
                                                  )));
                                    }
                                  }
                                } else {
                                  Toast.show('no creds'.tr(), context,
                                      duration: Toast.LENGTH_LONG);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
