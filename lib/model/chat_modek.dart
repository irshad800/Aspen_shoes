class ChatMessageModel {
  final String userId;
  final String text;
  final String createdAt;

  ChatMessageModel({
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  // Convert a ChatMessageModel object into a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'text': text,
      'createdAt': createdAt,
    };
  }

  // Convert a Map<String, dynamic> into a ChatMessageModel object
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      userId: map['userId'],
      text: map['text'],
      createdAt: map['createdAt'],
    );
  }
}
