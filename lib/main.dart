import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_router.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.getUser();
        return cubit;
      },
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<AuthCubit>(context);

        return BlocBuilder<AuthCubit, AuthState>(
          bloc: cubit,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chat App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                useMaterial3: true,
              ),
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute:  state is AuthSuccess ? AppRoutes.home : AppRoutes.login,
            );
          },
        );
      }),
    );
  }
}

