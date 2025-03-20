import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/view/constants/api_url.dart';

import '../../view/constants/enums.dart';
import 'package:http/http.dart' as http;

class LatestNewsApi extends ChangeNotifier {
  ApiState newsApiState = ApiState.none;
  String? error;
  List? news;

  Future<void> getNews() async {
    newsApiState = ApiState.loading;
    try {
      final res = await http.get(
        Uri.parse(latestNewsUrl),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        newsApiState = ApiState.succesful;
        error = null;
        news = await jsonDecode(utf8.decode(res.bodyBytes))['results'];
      }
    } on Exception catch (e) {
      newsApiState = ApiState.error;
      error = e.toString();
      news = null;
    } finally {
      notifyListeners();
    }
  }
}
