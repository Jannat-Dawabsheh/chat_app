part of 'conversation_cubit.dart';

@immutable
sealed class ConversationState {
  const ConversationState();

  get carouselItems => null;
}

final class ConversationInitial extends ConversationState {}
final class ConversationLoading extends ConversationState{}
final class ConversationLoaded extends ConversationState{

 final List<UserData>users;
 
 const ConversationLoaded({
  required this.users,
 });
}

final class ConversationError extends ConversationState{

 final String message;
 const ConversationError({
  required this.message,
 });
}



