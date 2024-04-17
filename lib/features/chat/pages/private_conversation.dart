import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/services/user_services.dart';
import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/chat/manager/conversation/conversation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateConversation extends StatefulWidget {
  const PrivateConversation({super.key});

  @override
  State<PrivateConversation> createState() => _PrivateConversationState();
}

class _PrivateConversationState extends State<PrivateConversation> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ConversationCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final userServices = UserServices();
     final user=UserServices();
      List<UserData> usersList=[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap:() =>Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.home),
                  child:const Icon(Icons.home)
                  ),
                const SizedBox(width: 10,),
                InkWell(
                  onTap:() async =>await authCubit.logout(),
                  child: const Icon(Icons.logout_outlined)
                  ),
                  ],
                ),
              ),
            ],
          ),
           body:BlocListener<AuthCubit,AuthState>(
            bloc: authCubit,
            listenWhen: (previous, current) => current is AuthLoggedOut,
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }
            },

      child:BlocBuilder<ConversationCubit,ConversationState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is ConversationLoading|| current is ConversationError ||current is ConversationLoaded,
      builder: (context, state) {
        if(state is ConversationLoading){
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }else if(state is ConversationError){
          return  Center(
            child: Text(state.message),
          );
        }else if(state is ConversationLoaded){
          print('in loaded');
          print("users"+"${state.users.length}");
          print("rec"+"${state.recMsg.length}");
          print("sen"+"${state.senderMsg.length}");
          state.senderMsg.forEach((element) async { 
        final user=await userServices.getUserWithID(element.receiverId);
        usersList.add(user);
          //print('added');
        });
        print("list"+"${usersList.length}");
       
        return SafeArea(
        
           child: SingleChildScrollView(
             child: Column(
                     
               children: [
                 ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   padding: const EdgeInsets.all(10),
                   itemCount:state.users.length,
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
                           Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.chat, arguments: state.users[index].id);
                         },
                         ),
                     );
                   },),
               ]
               ),
           
           )
               );
        
        return const SizedBox.shrink();
      }      
      else {
          return const SizedBox.shrink();
        }
      
      }
      ) 
     
 ));
      
        
  }
}