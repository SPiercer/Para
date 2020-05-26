import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:para_new/Utils/webView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';

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
            height: MediaQuery.of(context).size.height * .80,
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
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final commission = prefs.get('commission');

                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'information',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ).tr(context: context),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.person),
                                              Text(widget.doctor['name'])
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(Icons.attach_money),
                                              Text('الحجز: '),
                                              Text(widget.doctor[
                                                      'disclosure_price'] +
                                                  ' | '),
                                              //      Icon(Icons.money_off),
                                              Text('العمولة: '),
                                              Text(commission.toString())
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.monetization_on),
                                              Text('الاجمالي: '),
                                              Text((commission +
                                                      double.parse(widget
                                                              .doctor[
                                                          'disclosure_price']))
                                                  .toString())
                                            ],
                                          ),
                                          Divider(),
                                          Text(
                                            'في حاله عدم الحضور لا يتم استرجاع المبلغ و في حاله التأخر عن الموعد يتم ادخالك بعد اخر مراجع',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
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
                                    onPressed: () async {
                                      Toast.show('Please Wait', context,
                                          duration: 60);
                                      var response = await APIs.sendMyDate(
                                          url: serverUrl +
                                              "/${'lang'.tr()}/api/paymantAppointment",
                                          id: "${item['id']}");
                                      print('----------------------------');
                                      print(response);
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WView(
                                                    response: response,
                                                    order: item['id'],
                                                  )));
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
                        listOfTiles = [];
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
