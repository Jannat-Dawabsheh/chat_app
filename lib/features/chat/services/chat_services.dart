import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_path.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';

class ChatServices{
  final firestoreServices=FirestoreServices.instance;

  Future<void> sendMessage(ChatMessage message)async=>
   firestoreServices.setData(
    path: ApiPath.sendMessage(message.id), 
    data: message.toMap(),
    );

  Stream<List<ChatMessage>>getMessage()=>firestoreServices.collectionStream(
    path: ApiPath.message(), 
    builder: ((data, documentId) => ChatMessage.fromMap(data)),
    );
  
}