import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/features/chat/models/chat_message.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  
 final chatServices = ChatServices();
  final userServices = UserServices();
  Future<void>sendMessage(String text)async{
    emit(ChatMessaging());
    try{
      final sender = await userServices.getUser();
      final chatMessage=ChatMessage(
        id: DateTime.now().toIso8601String(),
        senderId: sender.id,
        senderName: sender.username,
        senderPhoto: sender.photoUrl,
        message: text,
        dateTime: DateTime.now(),
      );
      await chatServices.sendMessage(chatMessage);
      emit(ChatMessageSent());
    }catch(e){
      emit(ChatMessageError(e.toString()));
    }
  }

  Future<void>getMessages()async{
    emit(ChatLoading());
    try{
      final messagesStream=chatServices.getMessage();
      messagesStream.listen((message) { 
        emit(ChatSuccess(message));
      });
    }catch(e){
      emit(ChatError(e.toString()));
    }

  }



}
