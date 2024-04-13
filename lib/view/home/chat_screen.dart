// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:chat_group/api/supabase_api.dart';
import 'package:chat_group/core/common/loader.dart';
import 'package:chat_group/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_model.dart';

TextEditingController messageController = TextEditingController();
ScrollController scrollController = ScrollController();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    // Fetch current user data once
    _getCurrentUserData();
  }

  void _getCurrentUserData() async {
    try {
      final supabase = Supabase.instance.client;
      final String myId = supabase.auth.currentUser!.id;
      final userData = await API.getUserData(myId);
      setState(() {
        currentUser = userData!;
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void signOut() {
    API.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(fontFamily: "LobsterTwo"),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: API.getAllMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loader();
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Messages Yet"),
                  );
                } else {
                  var messages = snapshot.data;
                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: messages!.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return FutureBuilder(
                        future: API.getUserData(message.user_id),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Loader();
                          }
                          var user = snapshot.data;
                          bool isMe = currentUser.user_id == user!.user_id;
                          return Directionality(
                            textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[700],
                                    backgroundImage: NetworkImage(user.user_avatar),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.user_name,
                                        style: TextStyle(
                                            color: Colors.grey[700], fontWeight: FontWeight.bold),
                                      ),
                                      Text(message.message),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    cursorColor: const Color(0xFF0D47A1),
                    cursorHeight: 25,
                    controller: messageController,
                    style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 13),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(color: Colors.grey.shade700, height: 1.6, fontSize: 13),
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    MessageModel messageModel = MessageModel(
                      message: messageController.text.trim(),
                      user_id: currentUser.user_id,
                    );
                    API.sendMessage(messageModel);
                    scrollController.jumpTo(0);
                    log(messageController.text);
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
