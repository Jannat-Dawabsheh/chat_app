import 'package:chat_app/core/utils/constants/app_colors.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/chat/manager/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChatCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final reciverId=ModalRoute.of(context)!.settings.arguments as String;
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              await authCubit.logout();
            },
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listenWhen: (previous, current) => current is AuthLoggedOut,
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is ChatSuccess || current is ChatError,
                  builder: (context, state) {
                    if (state is ChatSuccess) {
                      final currentUserId=state.currentUserId;
                      final privateMessages=state.message.where((element) => (element.receiverId==reciverId&&element.senderId==currentUserId)||(element.receiverId==currentUserId&&element.senderId==reciverId)).toList();
                      if (privateMessages.isEmpty) {
                        return const Center(
                          child: Text('No messages'),
                        );
                      }
                      return ListView.builder(
                        itemCount: privateMessages.length,
                        itemBuilder: (context, index) {
                          //final message = state.message[index];
                         
                          final message = privateMessages[index];
                          return currentUserId==message.senderId
                          ?Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  message.senderPhoto,
                                ),
                                radius: 40,
                              ),
                              title: Text(message.message),
                              subtitle: Text(
                                'You',
                                style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.grey,
                                ),
                                ),
                            ),
                          )
                          :ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                message.senderPhoto,
                              ),
                              radius: 40,
                            ),
                            title: Text(message.message),
                            subtitle: Text(
                              message.senderName,
                               style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                color: AppColors.primary,
                              ),
                              ),
                          );
                        },
                      );
                    } else if (state is ChatError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: const OutlineInputBorder(),
                  suffixIcon: BlocConsumer<ChatCubit, ChatState>(
                    bloc: cubit,
                    listenWhen: (previous, current) =>
                        current is ChatMessageSent,
                    listener: (context, state) {
                      if (state is ChatMessageSent) {
                        _messageController.clear();
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is ChatMessaging ||
                        current is ChatMessageSent,
                    builder: (context, state) {
                      if (state is ChatMessaging) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          await cubit.sendMessage(_messageController.text,reciverId);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
