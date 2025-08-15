import 'package:flutter/foundation.dart';
import '../model/chat_model.dart';
import '../services/chat_service.dart';

class ChatListViewModel extends ChangeNotifier {
  final ChatService _service = ChatService();
  List<Chat> chats = [];
  bool isLoading = false;

  Future<void> loadChats() async {
    isLoading = true;
    notifyListeners();

    final fetchedChats = await _service.fetchChats();

    // Group by user ID — keep the latest chat only
    final latestChats = <String, Chat>{};
    for (var chat in fetchedChats) {
      if (!latestChats.containsKey(chat.userId) ||
          chat.lastMessageTime.isAfter(
            latestChats[chat.userId]!.lastMessageTime,
          )) {
        latestChats[chat.userId] = chat;
      }
    }

    // Sort by latest message
    chats = latestChats.values.toList()
      ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

    isLoading = false;
    notifyListeners();
  }
}
