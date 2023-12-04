import 'dart:convert';

import 'package:chat_ai/model/ai_model.dart';
import 'package:chat_ai/res/strings/const.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatAiController extends GetxController {
  RxList historyList = RxList<AizenModel>(
    [],
  );

  RxBool isLoading = false.obs;
  void sendPrompt(String prompt) async {
    isLoading.value = true;
    var newHistory = AizenModel(system: "you", message: prompt);
    historyList.add(newHistory);
    final body = {
      "prompt": {
        "text": prompt,
      }
    };
    final request = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final response = jsonDecode(request.body);
    final aizenReply = response["candidates"][0]["output"];
    var newHistory2 = AizenModel(system: "aizen", message: aizenReply);
    historyList.add(newHistory2);
    if (kDebugMode) {
      print(aizenReply.toString());
    }
    isLoading.value = false;
  }
}
