import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/consts.dart';
import '../model/message_model.dart';

class MessageService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://45.129.87.38:6065"));

  Future<List<Message>> fetchMessages(String chatId) async {
    try {
      final response = await _dio.get(
        "/messages/get-messagesformobile/$chatId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return (response.data as List)
          .map((e) => Message.fromJson(e, userId))
          .toList();
    } catch (ex) {
      debugPrint("Message fetch error: $ex");
      return [];
    }
  }

  Future<bool> sendMessage(String chatId, String content) async {
    try {
      await _dio.post(
        "//messages/sendMessage",
        data: {
          "chatId": chatId,
          "senderId": userId,
          "content": content,
          "messageType": "text",
          "fileUrl": "",
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return true;
    } catch (ex) {
      debugPrint("Send message error: $ex");
      return false;
    }
  }
}
