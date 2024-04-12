import 'package:chat_app/core/models/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        title: Text('Chat'),
      ),
      body: Container(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(users[index].photoUrl),
                      ),
                      title: Text(users[index].username,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(users[index].email,
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      onTap: (() {


                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) => ChatScreen(
                        //             name: users[index].username,
                        //             photoUrl: users[index].photoUrl,
                        //             receiverUid:
                        //                 users[index].id)));
                      }),
                    );
                  }),
                ),
              )
      );
  }
}

 