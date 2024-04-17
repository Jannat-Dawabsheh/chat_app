

import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_path.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';
import 'package:chat_app/features/chat/manager/privetConv_cubit/privetCon_cubit.dart';

abstract class PrivateConv {
  Future<List<UserData>> getPrivateConvs();
  Future<void> addToConv(UserData user);
}

class PrivateConvImpl implements PrivateConv {
  final firestore = FirestoreServices.instance;
  final authServices = AuthServicesImpl();

  @override
  Future<List<UserData>> getPrivateConvs() async {
    final currentUser = await authServices.getUser();
    return await firestore.getCollection(
      path: ApiPath.getPrivateConv(currentUser!.uid),
      builder: (data, documentId) => UserData.fromMap(data),
    );
  }

  @override
  Future<void> addToConv(UserData user) async {
    final currentUser = await authServices.getUser();

    await firestore.setData(
      path: ApiPath.addConversation(
        currentUser!.uid,
        user.id,
      ),
      data: user.toMap(),
    );
    
  }
  
}
