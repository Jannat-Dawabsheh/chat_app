import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
              
              child: Center(
                child: Column(
               
                  children: [
                    
                   const SizedBox(height: 30,),
                      Image.asset(
                        'assets/images/chatting.png',
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(//=>f('user/k0ibdjhTuabRLktmIuO3l8Sp43C3'),
                        onPressed: ()=>Navigator.of(context).pushNamed(AppRoutes.chatListPage),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                        ),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width*0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Find available users ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600)),
                            
                                const Icon(Icons.arrow_forward_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                
                
                  ],
                ),
              ),
            ));
  }
}