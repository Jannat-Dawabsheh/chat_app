part of 'privetCon_cubit.dart';

sealed class privateConvState {}
final class PrivateConvInitial extends privateConvState {}

final class PrivateConvLoading extends privateConvState {}

final class PrivateConvLoaded extends privateConvState {
  final List<UserData> users;

  PrivateConvLoaded({
    required this.users,
  });
}

final class PrivateConvError extends privateConvState {
  final String message;

  PrivateConvError({
    required this.message,
  });
}

