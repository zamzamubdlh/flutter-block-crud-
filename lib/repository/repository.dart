import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
    final Dio _dio = Dio();

    try {
      //source check session
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String sessionToken = prefs.getString('session') ?? "";
      Map fdataMap = {'session_token': sessionToken};
      FormData fdata = FormData();
      fdata.fields
          .addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
      final response = await _dio.post(
        'https://tugas9faura.000webhostapp.com/pemMobile/session.php',
        data: fdata,
      );

      log("check session $response");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.data);
        return data['status'] == 'success';
      }
    } catch (error) {
      //handle error if needed
    }
    return false;
  }
}
