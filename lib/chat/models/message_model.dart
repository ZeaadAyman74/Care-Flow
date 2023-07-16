class MessageModel {
  final String senderId;
  final String receiverId;
  final String dateTime;
  final String text;

  MessageModel({
    required this.text,
    required this.receiverId,
    required this.senderId,
    required this.dateTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        text: json['text'],
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        dateTime: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
      'date': dateTime,
    };
  }
}
