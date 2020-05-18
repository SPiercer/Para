import 'package:flutter/material.dart';
import 'package:para_new/Utils/APIs.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
class WView extends StatefulWidget {
  final response;
  final order;
  WView({this.response, this.order});
  @override
  _WViewState createState() => _WViewState();
}

class _WViewState extends State<WView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (page) {
        if (Uri.dataFromString(page).queryParameters['Result'] ==
            'Successful') {
          APIs.success(id: widget.order);
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
                                          Text('done')
                                              .tr(context: context),
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
                        
                                ],
                              );
                            },
                          );

        }
      },
      initialUrl:
          Uri.dataFromString(widget.response['html'], mimeType: 'text/html')
              .toString(),
    );
  }
}
