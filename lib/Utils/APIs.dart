import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/constants.dart';

class APIs {
  //Clinics API ************************************
  static Future getClinics(url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  //Dates API **************************************
  static Future getMyDates(url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static Future sendMyDate({String url, id}) async {
    // url = "/${'lang'.tr()}/api/appointment/${item['id']}"
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'appointment_id': '$id'
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static Future success({id}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response =
        await http.post(serverUrl + '/ar/api/appointment', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'appointment_id': '$id'
    });
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse;
  }

  //Doctors API *************************************
  static Future getAllDoctors(url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  //Specialties API ************************************
  static Future getAllSpecialties(url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  //User API ********************************************
  static void getCommission() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('commission')) prefs.remove('commission');
    final token = prefs.get('token');
    String myUrl = serverUrl + "/${'lang'.tr()}/api";
    final response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    double commission = double.parse(jsonResponse['commission']);
    prefs.setDouble('commission', commission);
    print(prefs.get('commission'));
  }

  static Future getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    String myUrl = serverUrl + "/${'lang'.tr()}/api/user/details";
    final response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static Future updateUser(
    String name,
    File image,
    String password,
    String passwordConfirmation,
  ) async {
    String url = serverUrl + "/${'lang'.tr()}/api/user/update";
    Map<String, dynamic> responseJson = new Map();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    String base64Image = '';
    if (image != null) {
      List<int> imageBytes = image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'name': "$name",
        'image': "$base64Image",
        'password': "$password",
        'passwordConfirmation': "$passwordConfirmation",
      },
    );
    responseJson = json.decode(response.body);
    return responseJson;
  }
}
