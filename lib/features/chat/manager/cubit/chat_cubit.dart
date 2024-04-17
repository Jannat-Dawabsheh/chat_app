import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';
import 'package:chat_app/features/chat/models/conversation_model.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:chat_app/features/chat/services/conversations.dart';
import 'package:chat_app/features/chat/services/privateConv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  
 final chatServices = ChatServices();
 final userServices = UserServices();
 final conversationServices = ConversationServices();
final convServices = PrivateConvImpl();
  Future<void>sendMessage(String text, String receiverId)async{
    emit(ChatMessaging());
    try{
      final sender = await userServices.getUser();
      final chatMessage=ChatMessage(
        id: DateTime.now().toIso8601String(),
        senderId: sender.id,
        senderName: sender.username,
        receiverId:receiverId,
        senderPhoto: sender.photoUrl,
        message: text,
        dateTime: DateTime.now(),
      );
      await chatServices.sendMessage(chatMessage);
      emit(ChatMessageSent(receiverId,sender.id));
      
    }catch(e){
      emit(ChatMessageError(e.toString()));
    }
  }

  Future<void>getMessages()async{

    emit(ChatLoading());
    try{
      final currentUser=await userServices.getUser();
      final messagesStream=chatServices.getMessage();
      messagesStream.listen((message) { 
        emit(ChatSuccess(message, currentUser.id));
      });
    }catch(e){
      emit(ChatError(e.toString()));
    }

  }


Future<void>addConversation(String receiverId)async{
    try{
      final sender = await userServices.getUser();
      final conversationModel=ConversationModel(
        id: sender.id+receiverId,
        senderId: sender.id,
        receiverId:receiverId,
      );
      await conversationServices.AddConversation(conversationModel);
    }catch(e){
      emit(ChatMessageError(e.toString()));
    }
  }

   Future<void> addToConv(String userid) async {
    emit(privateConAdding());
    try {
      final currentUser = await userServices.getUser();
      final selectedUser = await UserServices().getUserWithID(userid);
    final user = UserData(id: selectedUser.id, email: selectedUser.email, username: selectedUser.username, password: selectedUser.password, photoUrl: selectedUser.photoUrl);
    await convServices.addToConv(user,currentUser);
    emit(
          privateConAdded(user: user),
        );
    } catch (e) {
      emit(
        PrivateConvError(message: e.toString()),
      );
    }
  }




}
