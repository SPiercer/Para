import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../clinics.dart';
import '../doctorspages/doctors.dart';
import '../specialties.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    "images/logo_with_title.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              ),
              flex: 5,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("images/home_background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Flexible(
                              child: Container(),
                              flex: 1,
                            ),
                            Flexible(
                              child: InkWell(
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "images/doctors.png",
                                                ),
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Flexible(
                                            child: Container(
                                                child: Center(
                                                    child: Text(
                                              'doctors',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23),
                                            ).tr(context: context))),
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Doctors()));
                                },
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Flexible(
                              child: InkWell(
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "images/specialties.png",
                                                ),
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Flexible(
                                            child: Container(
                                                child: Center(
                                                    child: Text(
                                              'specialties',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23),
                                            ).tr(context: context))),
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Specialties()));
                                },
                              ),
                              flex: 2,
                            ),
                            Flexible(
                              child: Container(),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Flexible(
                              child: Container(),
                              flex: 1,
                            ),
                            Flexible(
                              child: InkWell(
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "images/clincs.png",
                                                ),
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Flexible(
                                            child: Container(
                                                child: Center(
                                                    child: Text(
                                              'clinics',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23),
                                            ).tr(context: context))),
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Clinics()));
                                },
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
