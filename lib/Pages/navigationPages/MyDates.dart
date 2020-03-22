import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Helpers/TrianglePainter.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Utils/APIs.dart';

class MyDates extends StatefulWidget {
  @override
  _MyDatesState createState() => _MyDatesState();
}

class _MyDatesState extends State<MyDates> {
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
      await APIs.getMyDates(nextLink).then((value) {
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
    await APIs.getMyDates(serverUrl + "/${'lang'.tr()}/api/user/appointments?page=1")
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
          leading: Icon(Icons.access_time),
          centerTitle: true,
          title: Text('appointments').tr(context: context),
          backgroundColor: UIColors.PRIMARY_COLOR,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final date = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: (MediaQuery.of(context).size.height / 10) - 15,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          child: Container(
                            height: (MediaQuery.of(context).size.height / 2.5) -
                                ((MediaQuery.of(context).size.height / 10) -
                                    15),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    color: Colors.white,
                                    child: Align(
                                      alignment: Alignment(.83, -1),
                                      child: CustomPaint(
                                        size: Size(20, 15),
                                        painter: TrianglePainter(
                                          strokeColor:
                                              UIColors.BACKGROUND_COLOR,
                                          strokeWidth: 10,
                                          paintingStyle: PaintingStyle.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Flexible(
                                  child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${date['doctor']['clinic']['image_path']}"),
                                                    ),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      "${date['doctor']['clinic']['name']}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: UIColors
                                                              .PRIMARY_COLOR),
                                                    ),
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          ),
                                          flex: 1,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Divider(
                                              height: 1,
                                              color: Color(0x55000000),
                                            )),
                                        Flexible(
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "${date['doctor']['name']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: UIColors
                                                                .PRIMARY_COLOR),
                                                      ),
                                                    ),
                                                  ),
                                                  flex: 3,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Container(
                                                      decoration: BoxDecoration(
                                                          color: UIColors
                                                              .PRIMARY_COLOR,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          13))),
                                                      child: Center(
                                                        child: Text(
                                                          "${date['doctor']['specialty']['name']}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                                  ),
                                                  flex: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Divider(
                                              height: 1,
                                              color: Color(0x55000000),
                                            )),
                                        Flexible(
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Center(
                                                        child: Icon(Icons
                                                            .monetization_on)),
                                                  ),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "${date['doctor']['disclosure_price']} ${'sr'.tr()}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: UIColors
                                                                .PRIMARY_COLOR),
                                                      ),
                                                    ),
                                                  ),
                                                  flex: 7,
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Divider(
                                              height: 1,
                                              color: Color(0x55000000),
                                            )),
                                        Flexible(
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Center(
                                                        child: Icon(
                                                            Icons.thumb_up)),
                                                  ),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        'no examination',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: UIColors
                                                                .PRIMARY_COLOR),
                                                      ).tr(context: context),
                                                    ),
                                                  ),
                                                  flex: 7,
                                                ),
                                              ],
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 9,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: (MediaQuery.of(context).size.height / 2.5) -
                            (MediaQuery.of(context).size.height / 11.5),
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 11.5,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Flexible(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Icon(
                                                Icons.access_time,
                                                color: UIColors.SECONDARY_COLOR,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          flex: 9,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                                child: Text(
                                              "${date['date']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color:
                                                      UIColors.SECONDARY_COLOR),
                                            )),
                                          ),
                                          flex: 13,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Container(
                                            width: 2,
                                            color: UIColors.PRIMARY_COLOR,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                'from',
                                                style: TextStyle(
                                                    color:
                                                        UIColors.PRIMARY_COLOR,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ).tr(context: context),
                                            ),
                                          ),
                                          flex: 9,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "${date['from']}",
                                                style: TextStyle(
                                                    color:
                                                        UIColors.PRIMARY_COLOR,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                'to',
                                                style: TextStyle(
                                                    color:
                                                        UIColors.PRIMARY_COLOR,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ).tr(context: context),
                                            ),
                                          ),
                                          flex: 9,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "${date['to']}",
                                                style: TextStyle(
                                                    color:
                                                        UIColors.PRIMARY_COLOR,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                flex: 3,
                              ),
                              Flexible(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment(.83, .8),
                                    child: CustomPaint(
                                      size: Size(20, 20),
                                      painter: TrianglePainter(
                                        strokeColor: Colors.white,
                                        strokeWidth: 10,
                                        paintingStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
