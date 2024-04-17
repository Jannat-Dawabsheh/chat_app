import 'package:bloc/bloc.dart';
import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/services/chat_services.dart';
import 'package:chat_app/features/chat/services/privateConv.dart';


part 'privitCon_state.dart';

class CartCubit extends Cubit<privitConState> {
  CartCubit() : super(PrivateConvInitial());
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

    Future<void> addToConv(String userid) async {
    emit(privateConAdding());
    try {
      final selectedUser = await UserServices().getUserWithID(userid);
    final user = UserData(id: selectedUser.id, email: selectedUser.email, username: selectedUser.username, password: selectedUser.password, photoUrl: selectedUser.photoUrl);
    await convServices.addToConv(user);
    emit(
          privateConAdded(user: user),
        );
    } catch (e) {
      emit(
        PrivateConvError(message: e.toString()),
      );
    }
  }


}
