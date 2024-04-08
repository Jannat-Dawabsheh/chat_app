import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/pages/create_account_page.dart';
import 'package:chat_app/features/auth/pages/login_page.dart';
import 'package:chat_app/features/chat/pages/home_page.dart';
import 'package:flutter/material.dart';

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

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) =>HomePage(),
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
