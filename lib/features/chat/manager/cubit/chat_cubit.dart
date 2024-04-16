import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';
import 'package:chat_app/features/chat/models/conversation_model.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:chat_app/features/chat/services/conversations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  
 final chatServices = ChatServices();
 final userServices = UserServices();
 final conversationServices = ConversationServices();

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


  // Future<void>getConversations()async{
  //    List<UserData> usersList=[];  
  //   try{
  //     final currentUser=await userServices.getUser();
  //     final conStream=conversationServices.getConversation();

  //     conStream.listen((conv) { 
  //      final senderMsg=conv.where((element) => (element.senderId==currentUser.id)).toList();    
  //     senderMsg.forEach((element) async { usersList.add(await userServices.getUserWithID(element.receiverId));});
  //     final recMsg=conv.where((element) => (element.receiverId==currentUser.id)).toList();
  //     recMsg.forEach((element) async {usersList.add(await userServices.getUserWithID(element.senderId));}); 
  //       emit(ConvSuccess(conv, currentUser.id,usersList));
  //       print('find user');
  //       print(usersList.length);
  //     });
  //    }
  //   catch(e){
  //     emit(ChatError(e.toString()));
  //   }

  // }



}
