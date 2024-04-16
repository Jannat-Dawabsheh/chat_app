part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {
}
final class ChatLoaded extends ChatState {}
final class ChatMessageSent extends ChatState {
  final String receiverId;
  final String currentUserId;
  ChatMessageSent(this.receiverId, this.currentUserId);
}
final class ChatMessaging extends ChatState {}
final class ChatMessageError extends ChatState {
   final String message;
  ChatMessageError(this.message);
}
final class ChatSuccess extends ChatState {
  final List<ChatMessage>message;
  final String currentUserId;
  ChatSuccess(this.message, this.currentUserId);
}
final class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

final class ConvSuccess extends ChatState {
  final List<ConversationModel>conv;
  final String currentUserId;
  final List<UserData> usersList;
  ConvSuccess(this.conv, this.currentUserId,this.usersList);
}

