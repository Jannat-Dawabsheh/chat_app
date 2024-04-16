class ConversationModel{
  final String id;
  final String senderId;
  final String receiverId;

  ConversationModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
  
    return result;
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
    );
  }
}
