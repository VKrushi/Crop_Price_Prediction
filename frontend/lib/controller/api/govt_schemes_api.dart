// import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:frontend/view/constants/api_url.dart';
import 'package:frontend/view/constants/raw_data.dart';

import '../../view/constants/enums.dart';
// import 'package:http/http.dart' as http;

class GovtSchemesApi extends ChangeNotifier {
  ApiState schemeApiState = ApiState.none;
  String? error;
  List? schemes;

  Future<void> getSchemes() async {
    schemeApiState = ApiState.loading;
    try {
      // final res = await http.get(
      //   Uri.parse(govtSchemeUrl),
      //   headers: {
      //     "Access-Control-Allow-Origin": "*",
      //     'Content-Type': 'application/json',
      //     'Accept': '*/*'
      //   },
      // );

      // if (res.statusCode == 200) {
      //   schemeApiState = ApiState.succesful;
      //   error = null;
      //   schemes = await jsonDecode(utf8.decode(res.bodyBytes));
      // }
      schemes = schemeList;
      for (int i = 0; i < 15; i++) {
        schemes![i]['Type'] = 0;
      }
      for (int i = 15; i < schemes!.length; i++) {
        schemes![i]['Type'] = 1;
      }
      schemeApiState = ApiState.succesful;
      return;
    } on Exception catch (e) {
      schemeApiState = ApiState.error;
      error = e.toString();
      schemes = null;
    } finally {
      notifyListeners();
    }
  }
}
