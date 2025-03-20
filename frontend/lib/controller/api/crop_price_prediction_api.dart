// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:frontend/view/constants/api_url.dart';
import 'package:frontend/view/constants/raw_data.dart';

import '../../view/constants/enums.dart';
// import 'package:http/http.dart' as http;

class CropPricePredictionApi extends ChangeNotifier {
  ApiState predictionApiState = ApiState.none;
  String? error;
  List<Map>? forecastedPrice;

  Future<void> predictPrice({
    required String crop,
  }) async {
    predictionApiState = ApiState.loading;
    try {
      forecastedPrice = [];
      List<double> pricePredictions = [];
      pricePredictions = getPredictions(crop);
      for (int i = 0; i < 12; i++) {
        forecastedPrice!.add(
          {
            'month': months[i],
            'price': pricePredictions[i],
          },
        );
      }
      // final res = await http.get(
      //   Uri.parse(cropPricePredictionUrl),
      //   headers: {
      //     "Access-Control-Allow-Origin": "*",
      //     'Content-Type': 'application/json',
      //     'Accept': '*/*'
      //   },
      // );

      // if (res.statusCode == 200) {
      //   predictionApiState = ApiState.succesful;
      //   error = null;
      //   forecastedPrice = await jsonDecode(res.body);
      // }
      predictionApiState = ApiState.succesful;
    } on Exception catch (e) {
      predictionApiState = ApiState.error;
      error = e.toString();
      forecastedPrice = null;
    } finally {
      notifyListeners();
    }
  }
}
