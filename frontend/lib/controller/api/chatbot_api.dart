import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/model/prompts.dart';
import '../../view/constants/enums.dart';
import 'package:http/http.dart' as http;

import '../../view/constants/api_url.dart';

class ChatbotApi extends ChangeNotifier {
  ApiState chatbotApiState = ApiState.none;
  String? error;
  String? response;

  Future<void> chat({
    required String prompt,
  }) async {
    chatbotApiState = ApiState.loading;
    notifyListeners();
    prompt = "$chatGeneralPrompt\n User Query: $prompt";
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
        chatbotApiState = ApiState.succesful;
        error = null;
        response = jsonDecode(res.body)["candidates"][0]["content"]["parts"][0]
            ["text"];

        chatbotApiState = ApiState.succesful;
      }
    } on Exception catch (e) {
      chatbotApiState = ApiState.error;
      error = e.toString();
      response = null;
    } finally {
      notifyListeners();
    }
  }
}
