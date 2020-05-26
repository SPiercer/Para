import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helpers/Constants.dart';
import '../Helpers/colors.dart';
import '../Utils/APIs.dart';
import '../Utils/home.dart';

class RegisterThirdStep extends StatefulWidget {
  RegisterThirdStep({Key key}) : super(key: key);

  @override
  _RegisterThirdStepState createState() {
    return _RegisterThirdStepState();
  }
}

class _RegisterThirdStepState extends State<RegisterThirdStep> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    await APIs.getUserData().then((user) {
      setState(() {
        this.name.text = user['name'];
        this.imagePath = user['image_path'];

        this.phone.text = user['phone'];
        this.password.text = '';
        this.passwordConfirmation.text = '';
      });
    });
  }

  void getImage() async {
    String path = await FilePicker.getFilePath(type: FileType.IMAGE);

    setState(() {
      this.image = new File(path);
    });
  }

  String imagePath;
  File image;
  bool registerApi = false;
  registerThirdStep() async {
    if (name.text.isEmpty) {
      showInSnackBar('no creds'.tr(), context, _scaffoldKey);
    } else {
      setState(() {
        this.registerApi = true;
      });
      await APIs.updateUser(
              name.text, image, password.text, passwordConfirmation.text)
          .then((response) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));

        setState(() {
          this.registerApi = false;
        });
      }, onError: (error) {
        setState(() {
          this.registerApi = false;
        });
      });
    }
  }

  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordConfirmation = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'back',
                        style: TextStyle(
                            fontSize: 14, color: UIColors.PRIMARY_COLOR),
                      ).tr(context: context),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    this.getImage();
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Container(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: CircleAvatar(
                                      backgroundImage: this.image != null
                                          ? FileImage(this.image)
                                          : NetworkImage(imagePath)),
                                )),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'profile picture',
                                style: TextStyle(
                                    color: UIColors.PRIMARY_COLOR,
                                    fontSize: 20),
                              ).tr(context: context),
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
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
                          controller: name,
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
                          controller: phone,
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
                          controller: password,
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
                          controller: passwordConfirmation,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    color: UIColors.PRIMARY_COLOR,
                    child: FlatButton(
                        onPressed: () {
                          if (!this.registerApi) this.registerThirdStep();
                        },
                        child: Container(
                          child: Center(
                              child: this.registerApi
                                  ? loadingIndicator
                                  : Center(
                                      child: Text(
                                        'edit',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ).tr(context: context),
                                    )),
                        )),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
