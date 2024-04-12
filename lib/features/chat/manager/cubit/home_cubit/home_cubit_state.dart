part of 'home_cubit_cubit.dart';

@immutable
sealed class HomeCubitState {
  const HomeCubitState();

  get carouselItems => null;
}

final class HomeCubitInitial extends HomeCubitState {}
final class HomeLoading extends HomeCubitState{}
final class HomeLoaded extends HomeCubitState{

 final List<UserData>users;
 
 const HomeLoaded({
  required this.users,
 });
}

final class HomeError extends HomeCubitState{

 final String message;
 const HomeError({
  required this.message,
 });
}



