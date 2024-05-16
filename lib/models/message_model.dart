class MessageModel {
  String message;
  String dateTime;
  String email;

  MessageModel({
    required this.message,
    required this.email,
    required this.dateTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      email: json['email'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message' :message ,
      'email' :email ,
      'dateTime' :dateTime ,

    };
  }
}
