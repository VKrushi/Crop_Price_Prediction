import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/view/constants/api_url.dart';

import '../../view/constants/enums.dart';
import 'package:http/http.dart' as http;

class CropPricePredictionApi extends ChangeNotifier {
  ApiState predictionApiState = ApiState.none;
  String? error;
  List<Map>? forecastedPrice;

  Future<void> predictPrice({
    required String crop,
  }) async {
    print('invoked');
    predictionApiState = ApiState.loading;
    try {
      final res = await http.get(
        Uri.parse(cropPricePredictionUrl),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        predictionApiState = ApiState.succesful;
        error = null;
        forecastedPrice = await jsonDecode(res.body);
      }
    } on Exception catch (e) {
      predictionApiState = ApiState.error;
      error = e.toString();
      forecastedPrice = null;
    } finally {
      notifyListeners();
    }
  }
}
