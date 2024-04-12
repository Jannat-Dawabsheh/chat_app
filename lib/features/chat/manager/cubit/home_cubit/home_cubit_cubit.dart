import 'package:bloc/bloc.dart';
import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());
  final homeServices= UserServices();
 
  Future<void> getHomeData() async {
    emit(HomeLoading());
    final users = await homeServices.getAllUsers();
    emit(
        HomeLoaded(
          users: users,
        ),
      );
  }
}
