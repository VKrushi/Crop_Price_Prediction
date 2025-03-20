import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/model/prompts.dart';
import '../../view/constants/enums.dart';
import 'package:http/http.dart' as http;

import '../../view/constants/api_url.dart';

class CropRecommendationApi extends ChangeNotifier {
  ApiState recommendationApiState = ApiState.none;
  String? error;
  String? recommendedCrop;

  // Future<void> recommendCrop({
  //   required double nitrogen,
  //   required double temperature,
  //   required double humidity,
  //   required double pH,
  //   required double rainfall,
  // }) async {
  //   recommendationApiState = ApiState.loading;
  //   try {
  //     final res = await http.get(
  //       Uri.parse(cropRecommendationUrl),
  //       headers: {
  //         "Access-Control-Allow-Origin": "*",
  //         'Content-Type': 'application/json',
  //         'Accept': '*/*'
  //       },
  //     );

  //     if (res.statusCode == 200) {
  //       recommendationApiState = ApiState.succesful;
  //       error = null;
  //       recommendedCrop = await jsonDecode(res.body);
  //     }
  //   } on Exception catch (e) {
  //     recommendationApiState = ApiState.error;
  //     error = e.toString();
  //     recommendedCrop = null;
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  Future<void> recommendCrop({
    required String location,
    required String weather,
    required String soil,
  }) async {
    recommendationApiState = ApiState.loading;
    notifyListeners();
    final prompt =
        "$cropRecommendationPrompt \n  Following is the details given by user - Location : $location \n Weather : $weather \n Soil : $soil";

    try {
      final res = await http.post(Uri.parse(geminiUrl),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({
            "contents": [
              {
                "parts": [
                  {"text": prompt}
                ]
              }
            ]
          }));

      if (res.statusCode == 200) {
        recommendationApiState = ApiState.succesful;
        error = null;
        inspect(res);
        recommendedCrop = jsonDecode(res.body)["candidates"][0]["content"]
            ["parts"][0]["text"];

        recommendationApiState = ApiState.succesful;
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
