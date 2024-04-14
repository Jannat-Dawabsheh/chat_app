class ChatMessage{
  final String id;
  final String message;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String senderPhoto;
  final DateTime dateTime;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.senderPhoto,
    required this.message,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'senderName': senderName});
    result.addAll({'senderPhoto': senderPhoto});
    result.addAll({'message': message});
    result.addAll({'dateTime': dateTime.millisecondsSinceEpoch});
  
    return result;
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderPhoto: map['senderPhoto'] ?? '',
      message: map['message'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }
}
