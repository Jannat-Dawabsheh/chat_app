import 'package:chat_app/core/models/user_data.dart';
import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/chat/manager/cubit/home_cubit/home_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('vailable useres'),
        centerTitle: true,
      ),
      body:BlocBuilder<HomeCubitCubit,HomeCubitState>(
      bloc: BlocProvider.of<HomeCubitCubit>(context),
      builder: (context, state) {
        if(state is HomeLoading){
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
              
              child: Center(
                child: Column(
               
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
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
                              Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.chat, arguments: state.users[index].id);
                            },
                            ),
                        );
                      },),
                  ]
                  )
                  )
                  )
                  );
      
        
      }else {
          return const SizedBox.shrink();
        }
      
      }
      ) 
      );
  }
}

 