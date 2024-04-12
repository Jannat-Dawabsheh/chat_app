import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/chat/manager/cubit/home_cubit/home_cubit_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BlocBuilder<HomeCubitCubit,HomeCubitState>(
      bloc: BlocProvider.of<HomeCubitCubit>(context),
      builder: (context, state) {
        if(state is HomeLoading){
          print("loading");
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }else if(state is HomeError){
          return  Center(
            child: Text(state.message),
          );
        }else if(state is HomeLoaded){
        return RefreshIndicator(
          onRefresh:()async{
            await BlocProvider.of<HomeCubitCubit>(context).getHomeData();
          },
           child: SafeArea(
              
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.users.length,
                itemBuilder: (context,index){
                
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.users[index].photoUrl),
                      ),
                      title: Text(
                        state.users[index].username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary
                        ),
                      ),
                      
                      onTap: () {
                        
                      },
                      ),
                  );
                },),
            ));
         
          // SafeArea(
          //   child: Column(
          //               children: [
          //                 ListView.builder(
          //                   itemCount: state.users.length,
          //                   itemBuilder: ((context, index) {
          //                     return ListTile(
          //   leading: CircleAvatar(
          //     backgroundImage:
          //         NetworkImage(state.users[index].photoUrl),
          //   ),
          //   title: Text(state.users[index].username,
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //       )),
          //   subtitle: Text(users[index].email,
          //       style: TextStyle(
          //         color: Colors.grey,
          //       )),
          //   onTap: (() {
                          
                          
          //     // Navigator.push(
          //     //     context,
          //     //     new MaterialPageRoute(
          //     //         builder: (context) => ChatScreen(
          //     //             name: users[index].username,
          //     //             photoUrl: users[index].photoUrl,
          //     //             receiverUid:
          //     //                 users[index].id)));
          //   }),
          //                     );
          //                   }),
          //                 )
                             
          //                 //  ElevatedButton(//=>f('user/k0ibdjhTuabRLktmIuO3l8Sp43C3'),
          //                 //     onPressed: ()=>Navigator.of(context).pushNamed(AppRoutes.chatListPage),
          //                 //     style: ElevatedButton.styleFrom(
          //                 //       backgroundColor: AppColors.primary,
          //                 //       foregroundColor: AppColors.white,
          //                 //     ),
          //                 //     child: Text("start chatting",
          //                 //         style: Theme.of(context)
          //                 //             .textTheme
          //                 //             .titleMedium!
          //                 //             .copyWith(
          //                 //                 color: AppColors.white,
          //                 //                 fontWeight: FontWeight.w600)),
          //                 //   ),
            
                            
                     
          //               ],
          //   ),
          // ));
        
        }else {
          return const SizedBox.shrink();
        }
      },
    ));
  }
}
 final userServices = UserServices();
// Future<void>sendMessage(String text)async{
//     print(1);
//     try{
//       final sender = await userServices.getUser();
//       print(sender.email);
//       print(sender.id);
//       print(text);
//     }catch(e){
//       print(e.toString());
//     }
//   }
void f(String userId){
  FirebaseFirestore.instance

    .doc(userId)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
}
