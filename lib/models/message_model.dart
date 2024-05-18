class MessageModel {
  final String message;
  final String email;
  final String messageTime;

  MessageModel({
    required this.message,
    required this.email,
    required this.messageTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'] ?? '',
      email: json['email'] ?? '',
      messageTime: json['messageTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'email': email,
      'messageTime': messageTime,
    };
  }
}
