import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/features/chat/services/privateConv.dart';


part 'privitCon_state.dart';

class PrivateConvCubit extends Cubit<privateConvState> {
  PrivateConvCubit() : super(PrivateConvInitial());
  final convServices = PrivateConvImpl();
  Future<void> getConv() async {
    emit(PrivateConvLoading());
    try {
    final convList = await convServices.getPrivateConvs();
    emit(PrivateConvLoaded(
        users: convList,
      ));
    } catch (e) {
      emit(
       PrivateConvError(message: e.toString()),
      );
    }
  }



}
