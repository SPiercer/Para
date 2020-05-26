import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Auth/login.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Pages/RegisterThirdStep.dart';
import '../../Utils/APIs.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  WebViewController webCont;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        centerTitle: true,
        title: Text('profile page').tr(context: context),
        backgroundColor: UIColors.PRIMARY_COLOR,
        actions: <Widget>[],
      ),
      body: FutureBuilder(
          future: APIs.getUserData(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator);
            }
            if (snapshot.hasError) {
              return Center(child: Center(child: Text(snapshot.error)));
            }
            final item = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: UIColors.BACKGROUND_COLOR,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/profile_image.png"),
                                fit: BoxFit.fill),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 100, maxHeight: 100),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(item['image_path']),
                                        ),
                                      )),
                                ),
                                flex: 3,
                              ),
                              Flexible(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'information',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: UIColors.ICON_TEXT_COLOR),
                                      ).tr(context: context),
                                    ),
                                    flex: 6,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterThirdStep()));
                                      },
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                12,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                12,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Icon(
                                              Icons.edit,
                                              color: UIColors.ICON_TEXT_COLOR,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            flex: 1,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(right: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Image.asset(
                                                "images/profile_user.png"),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              item['name'],
                                            ),
                                          ),
                                        ),
                                        flex: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(right: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "${item['phone']}",
                                            ),
                                          ),
                                        ),
                                        flex: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Future<bool> clear() async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                          return true;
                                        }

                                        clear().then((done) {
                                          if (done)
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login()));
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: UIColors.SECONDARY_COLOR,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.backspace,
                                                      size: 15,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                  flex: 1,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        'logout',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ).tr(context: context),
                                                    ),
                                                  ),
                                                  flex: 7,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    flex: 3,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
