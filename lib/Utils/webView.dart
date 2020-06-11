import 'package:flutter/material.dart';
import 'package:para_new/Utils/APIs.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        } else if (Uri.dataFromString(page).queryParameters['Result'] ==
            'Failed') {
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text('برجاء التاكد من صحه البيانات و المحاولة مره اخري'),
              ));
        }
      },
      initialUrl:
          Uri.dataFromString(widget.response['html'], mimeType: 'text/html')
              .toString(),
    );
  }
}
