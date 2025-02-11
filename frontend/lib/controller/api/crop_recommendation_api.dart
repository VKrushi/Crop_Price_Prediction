import 'dart:convert';

import 'package:flutter/material.dart';
import '../../view/constants/enums.dart';
import 'package:http/http.dart' as http;

import '../../view/constants/api_url.dart';

class CropRecommendationApi extends ChangeNotifier {
  ApiState recommendationApiState = ApiState.none;
  String? error;
  String? recommendedCrop;

  Future<void> recommendCrop({
    required double nitrogen,
    required double temperature,
    required double humidity,
    required double pH,
    required double rainfall,
  }) async {
    recommendationApiState = ApiState.loading;
    try {
      final res = await http.get(
        Uri.parse(cropRecommendationUrl),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (res.statusCode == 200) {
        recommendationApiState = ApiState.succesful;
        error = null;
        recommendedCrop = await jsonDecode(res.body);
      }
    } on Exception catch (e) {
      recommendationApiState = ApiState.error;
      error = e.toString();
      recommendedCrop = null;
    } finally {
      notifyListeners();
    }
  }
}
