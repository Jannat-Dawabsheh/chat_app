import 'package:chat_app/features/chat/models/conversation_model.dart';
import 'package:chat_app/features/chat/services/conversations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/models/user_data.dart';

import 'package:chat_app/core/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(ConversationInitial());
   final userServices = UserServices();
   final conversationServices = ConversationServices();
   List<UserData> usersList=<UserData>[];
   List<int>l=<int>[];
  Future<void> getConversations() async {
    emit(ConversationLoading());

      final currentUser=await userServices.getUser();
      final conStream=conversationServices.getConversation();

      conStream.listen((conv) { 
       final senderMsg=conv.where((element) => (element.senderId==currentUser.id)).toList();    
       addf(senderMsg);
      final recMsg=conv.where((element) => (element.receiverId==currentUser.id)).toList();
      recMsg.forEach((element) async {usersList.add(await userServices.getUserWithID(element.senderId));}); 
        emit(ConversationLoaded(recMsg:recMsg,senderMsg:senderMsg, users:usersList));
        
      });

     }

     void addf(final senderMsg){
      senderMsg.forEach((element) async { 
        final user=await userServices.getUserWithID(element.receiverId);
        usersList.add(user);
      //print('added');
     });
     }
    

    
  }

