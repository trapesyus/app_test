import 'dart:convert';
import 'package:app_test/banka_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class bankInfo {
  Future <BankaApi?> bankBilgi() async {
    var response = await http.get(
        Uri.parse("https://api.sanalira.com/assignment"));
    if (response.statusCode == 200) {
      var gelencevap = BankaApi.fromJson(jsonDecode(response.body));
      return gelencevap;
    }
    else {
      debugPrint('İstek başarısız');
    }
  }
}