import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/constants.dart';

class DatabaseHelper {
  var status;
  var data;
  regData({String name, String phone, String pass, String passConfirm}) async {
    Map<String, dynamic> responseJson = new Map();
    String myUrl = "$serverUrl/${'lang'.tr()}/api/signup";

    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "name": "$name",
      "phone": "$phone",
      "password": "$pass",
      "password_confirmation": "$passConfirm",
    });
    responseJson = json.decode(response.body);
    return responseJson;
  }

  loginData(String phone, String password) async {
    String myUrl = "$serverUrl/${'lang'.tr()}/api/login";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "phone": "$phone",
      "password": "$password",
    });
    status = response.body.contains('error');
    data = json.decode(response.body);
  }

  resetPass({int phone}) async {
    String myUrl = "$serverUrl/${'lang'.tr()}/api/forget";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "phone": "$phone",
    });
    Map<String, dynamic> responseJson = new Map();
     responseJson = json.decode(response.body);
    return (responseJson);
  }

  verify(int pin, int id) async {

    String myUrl = "$serverUrl/${'lang'.tr()}/api/verification";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"pin": "$pin", "id": "$id"});
    Map<String, dynamic> responseJson = new Map();
    responseJson = json.decode(response.body);
    return responseJson;
  }

  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? null;
    return value;
  }
}
