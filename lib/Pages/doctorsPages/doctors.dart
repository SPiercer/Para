import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Utils/APIs.dart';
import '../../Utils/DateSelector.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  List<Map> items = [];
  String nextLink;
  int pages;
  Widget load;

  @override
  void initState() {
    super.initState();
    setState(() {
      load = RefreshProgressIndicator();
    });
    getPages();
  }

  Future<void> _neverSatisfied(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('sorry').tr(context: context),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('cancel').tr(context: context),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  addToList() async {
    setState(() {
      load = RefreshProgressIndicator();
    });
    if (nextLink != null) {
      await APIs.getAllDoctors(nextLink).then((value) {
        setState(() {
          nextLink = value['next_page_url'];
        });
        for (int i = 0; i < value['data'].length; i++) {
          items.add(value['data'][i]);
        }
      });
      setState(() {
        load = Text('more').tr(context: context);
      });
    } else
      _neverSatisfied('no results'.tr());
    setState(() {
      load = Text('more').tr(context: context);
    });
  }

  getPages() async {
    await APIs.getAllDoctors(
            serverUrl + "/${'lang'.tr()}/api/doctors?page=1")
        .then((value) {
      setState(() {
        nextLink = value['next_page_url'];
      });
      for (int i = 0; i < value['data'].length; i++) {
        items.add(value['data'][i]);
      }
    });
    setState(() {
      load = Text('more').tr(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: addToList,
          child: load,
        ),
        backgroundColor: UIColors.BACKGROUND_COLOR,
        appBar: AppBar(
          centerTitle: true,
          title: Text('doctors').tr(context: context),
          backgroundColor: UIColors.PRIMARY_COLOR,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              var doctor = items[index];
              var clinic = items[index]['clinic'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(
                    children: <Widget>[
                      //Container for middle info
                      Positioned(
                          top: (MediaQuery.of(context).size.height / 6.5) / 2,
                          bottom: MediaQuery.of(context).size.height / 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: (MediaQuery.of(context).size.height / 2) -
                                  (MediaQuery.of(context).size.height / 30),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Text(
                                        doctor['name'],
                                        style: TextStyle(
                                            color: UIColors.PRIMARY_COLOR,
                                            fontSize: 18),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 16, right: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              clinic['description'],
                                              style: TextStyle(
                                                  color: UIColors.PRIMARY_COLOR,
                                                  fontSize: 18),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Flexible(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(13),
                                            bottomLeft: Radius.circular(13)),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16),
                                          color: UIColors.PRIMARY_COLOR,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            child: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .white)),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                clinic['name'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                        ),
                                                        flex: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                            child: Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Colors
                                                                    .white)),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                clinic[
                                                                    'address'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                        ),
                                                        flex: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                            child: Icon(
                                                                Icons
                                                                    .monetization_on,
                                                                color: Colors
                                                                    .white)),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "${doctor['disclosure_price']} ${'sr'.tr()} ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ).tr(
                                                                  context:
                                                                      context)),
                                                        ),
                                                        flex: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          child: Icon(
                                                              Icons.access_time,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        flex: 1,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "${doctor['detection_duration']} ${'min'.tr()} ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              )),
                                                        ),
                                                        flex: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          ),
                                        )),
                                    flex: 4,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          bottom: (MediaQuery.of(context).size.height / 2) -
                              (MediaQuery.of(context).size.height / 6.5),
                          left: (MediaQuery.of(context).size.width / 1.6) -
                              (MediaQuery.of(context).size.height / 6.5),
                          right: (MediaQuery.of(context).size.width / 1.6) -
                              (MediaQuery.of(context).size.height / 6.5),
                          child: Container(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Center(
                              child: Container(
                                height: 85,
                                width: 85,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(doctor['image_path']),
                                ),
                              ),
                            ),
                          )),
                      //Container for button
                      Positioned(
                          top: (MediaQuery.of(context).size.height / 2) -
                              (MediaQuery.of(context).size.height / 15),
                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 12 + 20,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: (MediaQuery.of(context).size.height / 15),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => DoctorDates(doctor),
                                    );
                                  },
                                  color: UIColors.SECONDARY_COLOR,
                                  child: Center(
                                    child: Text(
                                      'book',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ).tr(context: context),
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }));
  }
}
