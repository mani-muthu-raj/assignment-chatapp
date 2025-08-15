import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/consts.dart';
import '../model/chat_model.dart';

class ChatService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://45.129.87.38:6065"));

  Future<List<Chat>> fetchChats() async {
    try {
      final response = await _dio.get(
        "/chats/user-chats/673d80bc2330e08c323f4393",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return (response.data as List).map((e) => Chat.fromJson(e)).toList();
    } catch (ex) {
      debugPrint("Chat fetch error: $ex");
      return [];
    }
  }
}
