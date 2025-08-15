class Chat {
  final String chatId;
  final String userId;
  final String userName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  Chat({
    required this.chatId,
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    // Extract first participant name and ID
    String name = '';
    String uid = '';
    if (json['participants'] != null && json['participants'].isNotEmpty) {
      final firstParticipant = json['participants'][0];
      name = firstParticipant['name'] ?? '';
      uid = firstParticipant['_id'] ?? '';
    }

    // Extract last message content safely
    String message = '';
    if (json['lastMessage'] != null) {
      message = json['lastMessage']['content'] ?? '';
    }

    // Extract last message time
    DateTime messageTime = DateTime.now();
    if (json['lastMessage'] != null &&
        json['lastMessage']['createdAt'] != null) {
      messageTime =
          DateTime.tryParse(json['lastMessage']['createdAt']) ?? DateTime.now();
    } else if (json['createdAt'] != null) {
      messageTime = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
    }

    return Chat(
      chatId: json['_id'] ?? '',
      userId: uid,
      userName: name,
      lastMessage: message,
      lastMessageTime: messageTime,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}
