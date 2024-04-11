
import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailControler;
  late final TextEditingController _passwordControler;
  late FocusNode _emailFocusNode, _passwordFocusNode;
  String? _email, _password;
  bool visibility = false;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailControler = TextEditingController();
    _passwordControler = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }


  void login(VoidCallback loginFunc) {
    debugPrint("Email: $_email, Password:$_password");
    if (_formKey.currentState!.validate()) {
      loginFunc();

    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<AuthCubit>(context);
    return Scaffold(
          appBar: AppBar(
        ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/chat.png',
                        width: MediaQuery.sizeOf(context).width*0.4,
                      ),
                      Text(
                        "Welcome Back",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Please, login with registered account!",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      TextFormField(
                        controller: _emailControler,
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          _emailFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                        },
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          labelStyle: const TextStyle(color: AppColors.grey), 
                          prefixIcon: const Padding(
                            padding:  EdgeInsets.only(left: 20, right: 5),
                            child:  Icon(Icons.email_outlined),
                          ),
                          prefixIconColor: AppColors.grey4,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color:AppColors.grey4, width: 1.0),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color:AppColors.primary, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:const BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _passwordControler,
                        onChanged: (value) => _password = value,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          _passwordFocusNode.unfocus();
                          login(()=>cubit.login(_emailControler.text, _passwordControler.text));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        obscureText: !visibility,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: AppColors.grey), 
                          prefixIcon: const Padding(
                            padding:  EdgeInsets.only(left: 20, right:5 ),
                            child:  Icon(Icons.lock),
                          ),
                          prefixIconColor: AppColors.grey4,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                visibility = !visibility;
                              });
                            },
                            child: Icon(visibility
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          suffixIconColor: AppColors.grey,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color:AppColors.grey4, width: 1.0),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color:AppColors.primary, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:const BorderSide(color: AppColors.red),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          // => showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) => const forgetPasswordModelSheet(),
                          // ),
                          child: Text(
                            "forget password?",
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: AppColors.primary,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          bloc:cubit,
                          listenWhen: (previous,current)=>current is AuthSuccess || current is AuthError,
                          listener: (context, state) {
                            if(state is AuthSuccess){
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login Success'),
                                ),
                              );
                              Navigator.of(context).pushNamed(AppRoutes.home);
                            }else if(state is AuthError){
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          buildWhen: (previous,current)=>current is AuthLoading || current is AuthError,
                          builder: (context, state) {
                            if(state is AuthLoading){
                              return ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                ),
                                child: const Center (child: CircularProgressIndicator.adaptive()),
                              );
                            }
                            return ElevatedButton(
                                onPressed: ()=>login(()=>cubit.login(_emailControler.text, _passwordControler.text)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                ),
                                child: Text("login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600)),
                              );
                          },
                        ),
                      ),
                      
                      const SizedBox(
                        height: 16,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.grey,
                                  )),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.createAccountPage);
                            },
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
