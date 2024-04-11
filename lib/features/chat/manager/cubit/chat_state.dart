part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatLoaded extends ChatState {}
final class ChatMessageSent extends ChatState {}
final class ChatSuccess extends ChatState {
  final List<ChatMessage>message;
  ChatSuccess(this.message);
}
final class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
