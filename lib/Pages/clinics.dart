import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Helpers/TrianglePainter.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Utils/APIs.dart';
import 'doctorspages/doctorsfromclinic.dart';

class Clinics extends StatefulWidget {
  @override
  _ClinicsState createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
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
      await APIs.getClinics(nextLink).then((value) {
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
    await APIs.getClinics(serverUrl + "/${'lang'.tr()}/api/clinics?page=1")
        .then((value) {
      setState(() {
        nextLink = value['next_page_url'];
      });
      for (int i = 0; i<value['data'].length; i++){
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
        title: Text('clinics').tr(context: context),
        backgroundColor: UIColors.PRIMARY_COLOR,
      ),
      body: Container(
          child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var clinic = items[index]['clinic'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width - 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      clinic['image_path']),
                                                )),
                                          ),
                                          flex: 7,
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: CustomPaint(
                                                size: Size(20, 20),
                                                painter: TrianglePainter(
                                                  isReversed: false,
                                                  strokeColor: Colors.white,
                                                  strokeWidth: 10,
                                                  paintingStyle:
                                                      PaintingStyle.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          flex: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                clinic['name'],
                                                style: TextStyle(
                                                    color:
                                                        UIColors.PRIMARY_COLOR,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  clinic['description'],
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
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
                          ),
                          flex: 3,
                        ),
                        Flexible(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  child: Icon(Icons.person)),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "${'number of'.tr()} : ${items.length}",
                                                  style: TextStyle(
                                                      color: UIColors
                                                          .PRIMARY_COLOR,
                                                      fontSize: 18),
                                                ),
                                              )),
                                              flex: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Divider(
                                      height: 2,
                                      color: UIColors.PRIMARY_COLOR,
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  child:
                                                      Icon(Icons.location_on)),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  clinic['address'],
                                                  style: TextStyle(
                                                      color: UIColors
                                                          .PRIMARY_COLOR,
                                                      fontSize: 18),
                                                ),
                                              )),
                                              flex: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 8, right: 8, top: 4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          child: FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DoctorClinic(
                                                              docList: clinic,
                                                            )));
                                              },
                                              color: UIColors.SECONDARY_COLOR,
                                              child: Center(
                                                child: Text(
                                                  'info and booking',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ).tr(context: context),
                                              )),
                                        ),
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              )),
                          flex: 5,
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
