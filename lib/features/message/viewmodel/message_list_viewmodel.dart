import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/message_model.dart';
import '../service/message_service.dart';

class MessageListViewModel extends ChangeNotifier {
  final MessageService _service = MessageService();
  List<Message> messages = [];
  bool isLoading = false;

  Future<void> loadMessages(String chatId) async {
    isLoading = true;
    notifyListeners();

    messages = await _service.fetchMessages(chatId);

    // Sort by time ascending
    messages.sort((a, b) => a.time.compareTo(b.time));

    isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String chatId, String content) async {
    if (content.trim().isEmpty) return;

    final success = await _service.sendMessage(chatId, content);
    if (success) {
      // Reload messages after sending
      await loadMessages(chatId);
    }
  }
}
