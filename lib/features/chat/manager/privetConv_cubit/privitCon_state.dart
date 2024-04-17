part of 'privetCon_cubit.dart';

sealed class privitConState {}
final class PrivateConvInitial extends privitConState {}

final class PrivateConvLoading extends privitConState {}

final class PrivateConvLoaded extends privitConState {
  final List<UserData> users;

  PrivateConvLoaded({
    required this.users,
  });
}

final class PrivateConvError extends privitConState {
  final String message;

  PrivateConvError({
    required this.message,
  });
}

final class privateConAdded extends privitConState {
  final UserData user;
  privateConAdded({required this.user});
}

final class  privateConAdding extends privitConState {}

