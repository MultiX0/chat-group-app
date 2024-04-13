class MessageModel {
  final String? message_id;
  final String message;
  final String user_id;
  MessageModel({
    this.message_id,
    required this.message,
    required this.user_id,
  });

  MessageModel copyWith({
    String? message_id,
    String? message,
    String? user_id,
  }) {
    return MessageModel(
      message_id: message_id ?? this.message_id,
      message: message ?? this.message,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'user_id': user_id,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message_id: map['message_id'] ?? "",
      message: map['message'] ?? "",
      user_id: map['user_id'] ?? "",
    );
  }
}
