class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime time;
  final bool isMine;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.time,
    required this.isMine,
  });

  factory Message.fromJson(Map<String, dynamic> json, String currentUserId) {
    return Message(
      id: json['_id'],
      senderId: json['senderId'],
      content: json['content'],
      time: DateTime.parse(json['sentAt']),
      isMine: json['senderId'] == currentUserId,
    );
  }
}
