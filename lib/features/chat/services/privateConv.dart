

import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/firestore_services.dart';
import 'package:chat_app/core/utils/api_path.dart';
import 'package:chat_app/features/auth/services/auth_services.dart';


abstract class PrivateConv {
  Future<List<UserData>> getPrivateConvs();
  Future<void> addToConv(UserData user,UserData nextUser);
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
  Future<void> addToConv(UserData user, UserData nextUser) async {

    await firestore.setData(
      path: ApiPath.addConversation(
        nextUser.id,
        user.id,
      ),
      data: user.toMap(),
    );

    await firestore.setData(
      path: ApiPath.addConversation(
        user.id,
        nextUser.id,
      ),
      data: nextUser.toMap(),
    );
    
  }
  
}
