import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_path.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';
import 'package:chat_app/features/chat/models/conversation_model.dart';

class ConversationServices{
  final firestoreServices=FirestoreServices.instance;

  Future<void> AddConversation(ConversationModel conv)async=>
   firestoreServices.setData(
    path: ApiPath.addConversation(conv.id), 
    data: conv.toMap(),
    );

  Stream<List<ConversationModel>>getConversation()=>firestoreServices.collectionStream(
    path: ApiPath.conversation(), 
    builder: ((data, documentId) => ConversationModel.fromMap(data)),
    );
  
}