import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Utils/APIs.dart';

class DoctorDates extends StatefulWidget {
  final doctor;

  DoctorDates(this.doctor);

  @override
  _DoctorDatesState createState() {
    return _DoctorDatesState();
  }
}

class _DoctorDatesState extends State<DoctorDates>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: MediaQuery.of(context).size.height * .70,
            width: MediaQuery.of(context).size.width - 32,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: UIColors.BACKGROUND_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(
                        width: 20,
                      ),
                      Text('available appointments').tr(context: context),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOfTiles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = listOfTiles[index];
                      return InkWell(
                        onTap: () {
                  
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('information').tr(context: context),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('back').tr(context: context),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('book').tr(context: context),
                                    onPressed: () {
                                      APIs.sendMyDate(serverUrl +
                                          "/${'lang'.tr()}/api/appointment/${item['id']}");
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.lightGreen),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            margin: EdgeInsets.all(5),
                            child: Center(child: Text(item['time']))),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(5),
                  color: Colors.white,
                  child: TableCalendar(
                    onCalendarCreated: (date1, date2, cf) async {
                      await APIs.getMyDates(serverUrl +
                              '/${'lang'.tr()}/api/doctors/${widget.doctor['id']}')
                          .then((dates) {
                        for (int i = 0; i < dates.length; i++) {
                          dates[i].forEach((k, v) {
                            setState(() {
                              events[DateTime.parse(k)] = v;
                            });
                          });
                        }
                      });
                    },
                    initialSelectedDay: DateTime.now(),
                    onDaySelected: (date, list) {
                      setState(() {
                        listOfTiles.addAll(list);
                      });
                    },
                    events: events,
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold),
                        centerHeaderTitle: true,
                        titleTextBuilder: (d, s) {
                          return ' ${DateFormat('EEEE ,d MMMM yyyy').format(d)} ';
                        }),
                    calendarController: _calendarController,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.black),
                      weekdayStyle: TextStyle(color: Colors.black),
                    ),
                    calendarStyle: CalendarStyle(
                      highlightToday: false,
                      selectedColor: Colors.green[400],
                      weekendStyle: TextStyle(color: Colors.black54),
                      weekdayStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<DateTime, List<dynamic>> events = new Map();
  CalendarController _calendarController = new CalendarController();
  List listOfTiles = new List();
}

class Date {
  String date;
  String from;
  int id;
  String to;
  bool selected = false;
  Date({this.date, this.from, this.id, this.to});

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      date: json['date'] as String,
      from: json['from'] as String,
      id: json['id'] as int,
      to: json['to'] as String,
    );
  }
}
