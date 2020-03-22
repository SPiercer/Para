import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Pages/doctorspages/doctorsfromspec.dart';
import '../Utils/APIs.dart';

class Specialties extends StatefulWidget {
  @override
  _SpecialtiesState createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
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
      await APIs.getAllSpecialties(nextLink).then((value) {
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
    await APIs.getAllSpecialties(
            serverUrl + "/${'lang'.tr()}/api/specialties?page=1")
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
      appBar: AppBar(
        backgroundColor: UIColors.PRIMARY_COLOR,
        title: Text('specialties').tr(context: context),
        centerTitle: true,
      ),
      body: Container(
          child: Container(
        color: UIColors.BACKGROUND_COLOR,
        child: StatefulBuilder(
          builder: (BuildContext context, setter) {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (MediaQuery.of(context).size.width / 3 - 64) /
                    (MediaQuery.of(context).size.height / 8),
              ),
              itemCount: items.length,
              itemBuilder: (context, e) {
                var specialty = items[e];
                return InkWell(
                  onTap: () {
                    if (items[e]['doctors'].length == 0) {
                      _neverSatisfied('no doctors'.tr());
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorsSpec(
                              docList: items[e]['doctors'], index: e)));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UIColors.PRIMARY_COLOR, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: Center(
                              child: Image.network(
                                specialty['image_path'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Flexible(
                          child: Container(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                specialty['name'],
                                style: TextStyle(
                                    color: UIColors.PRIMARY_COLOR,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      )),
    );
  }
}
