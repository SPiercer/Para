import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Helpers/scroll.dart';
import '../Utils/auth.dart';
import '../Utils/home.dart';
import 'forgetPass.dart';
import 'register.dart';
import 'verification.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String msgStatus = '';
  Widget load = Text(
    'login',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ).tr();
  _onPressed() {
    setState(() {
      if (_email.text.trim().toLowerCase().isNotEmpty &&
          _password.text.trim().isNotEmpty) {
        setState(() {
          load = loadingIndicator;
        });
        instance
            .loginData(_email.text.trim().toLowerCase(), _password.text.trim())
            .whenComplete(() {
          if (instance.data.containsKey('message')) {
            msgStatus = 'auth failed'.tr();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: <Widget>[
                    Center(
                      child: Text(
                        msgStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                );
              },
            );
            setState(() {
              load = Text(
                'login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ).tr();
            });
          } else {
            if (instance.data['user']['pin'] == null) {
              instance.save(instance.data["access_token"]);

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterSecondStep(
                          userid: instance.data['user']['id'])));
            }
          }
        });
      } else {
        msgStatus = 'auth failed'.tr();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                Center(
                  child: Text(
                    msgStatus,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            );
          },
        );
        setState(() {
          load = Text(
            'login',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ).tr();
        });
      }
    });
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    if (value != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  DatabaseHelper instance = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

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
                            image: AssetImage("images/loginBackGround.png"),
                            fit: BoxFit.fill)),
                    child: Center(
                      child: Image.asset(
                        "images/LogoWithOutLetters.png",
                        fit: BoxFit.fill,
                      ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 8.0),
                                child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Form(
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            decoration: new BoxDecoration(
                                              border: new Border.all(
                                                width: 0.5,
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: new TextFormField(
                                              controller: _email,
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
                                                    color: Colors.grey,
                                                    fontSize: 15.0),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 10.0,
                                                        right: 30.0,
                                                        bottom: 10.0,
                                                        left: 5.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            decoration: new BoxDecoration(
                                              border: new Border.all(
                                                width: 0.5,
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            child: new TextFormField(
                                              controller: _password,
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
                                                    color: Colors.grey,
                                                    fontSize: 15.0),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 10.0,
                                                        right: 30.0,
                                                        bottom: 10.0,
                                                        left: 5.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            child: Container(
                              child: Container(
                                child: InkWell(
                                    onTap: () async {
                                      Toast.show('Logging in', context,
                                          duration: Toast.LENGTH_LONG);
                                      await _onPressed();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: UIColors.PRIMARY_COLOR,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13))),
                                      child: Center(child: load),
                                    )),
                              ),
                            ),
                            flex: 1,
                          ),
                          Flexible(
                            child: Container(
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    'register',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: UIColors.PRIMARY_COLOR,
                                        decoration: TextDecoration.underline),
                                  ).tr(context: context),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    flex: 4),
                Flexible(
                  child: Container(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPass()));
                        },
                        child: Text(
                          'forgot password',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ).tr(context: context),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.redAccent,
                      child: Text(
                        'EN',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      onPressed: () {
                        EasyLocalization.of(context).locale =
                            Locale('en', 'US');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                    Icon(
                      Icons.language,
                      size: 38.0,
                    ),
                    FlatButton(
                      color: Colors.teal,
                      child: Text(
                        'AR',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      onPressed: () {
                        EasyLocalization.of(context).locale =
                            Locale('ar', 'EG');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                       
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
