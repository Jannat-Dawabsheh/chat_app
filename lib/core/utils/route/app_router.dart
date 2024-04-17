import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/pages/create_account_page.dart';
import 'package:chat_app/features/auth/pages/login_page.dart';
import 'package:chat_app/features/chat/manager/conversation/conversation_cubit.dart';
import 'package:chat_app/features/chat/manager/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/manager/home_cubit/home_cubit_cubit.dart';
import 'package:chat_app/features/chat/manager/privetConv_cubit/privetCon_cubit.dart';
import 'package:chat_app/features/chat/pages/chat_page.dart';
import 'package:chat_app/features/chat/pages/chats_list_page.dart';
import 'package:chat_app/features/chat/pages/home_page.dart';
import 'package:chat_app/features/chat/pages/private_conversation.dart';
import 'package:chat_app/features/chat/services/privateConv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      
      case AppRoutes.createAccountPage:
        return MaterialPageRoute(
          builder: (_) => const CreateAccountPage(),
          settings: settings,
        );
      
        case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

       case AppRoutes.privateConversation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
           create: (BuildContext context) {  
              final cubit = PrivateConvCubit();
              cubit.getConv();
              return cubit;
            },
         
            child:const PrivateConversation(),
          ),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
           create: (BuildContext context) {  
              final cubit = HomeCubitCubit(); 
              cubit.getHomeData();
            return cubit;
            },
         
            child:const HomePage(),
          ),
          settings: settings,
        );

        case AppRoutes.chatListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
           create: (BuildContext context) {  
              final cubit = HomeCubitCubit(); 
              cubit.getHomeData();
            return cubit;
            },
         
            child:const ChatListPage(),
          ),
          settings: settings,
        );
        
      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChatCubit();
              cubit.getMessages();
              return cubit;
            },
            child: const ChatPage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
