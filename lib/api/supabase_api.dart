// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_group/core/failure.dart';
import 'package:chat_group/view/auth/start_screen.dart';
import 'package:chat_group/view/home/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../utils/my_utils.dart';

final supabase = Supabase.instance.client;
final auth = supabase.auth;
SupabaseQueryBuilder get _chat => supabase.from('chat');
SupabaseQueryBuilder get _users => supabase.from('users');

class API {
  Future<void> registerNewUser(
      {required String email,
      required String password,
      required String user_name,
      required BuildContext context}) async {
    try {
      await auth.signUp(email: email, password: password).then((e) async {
        await addNewUser(e.user!.id, user_name);
        auth.signInWithPassword(email: email, password: password).then(
          (e) {
            showSnackBar(
              context,
              "loged In successfully",
            );
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) => const ChatScreen()),
              ModalRoute.withName('/'),
            );
          },
        );
      });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      log(e.toString());
      throw Failure(e.toString());
    }
  }

  Future<void> addNewUser(String user_id, String user_name) async {
    try {
      UserModel userModel = UserModel(
          user_id: user_id,
          user_avatar:
              "https://firebasestorage.googleapis.com/v0/b/viblify.appspot.com/o/user.jpg?alt=media&token=beba7cb7-c3db-4c51-8449-edc0fac54605",
          user_name: user_name);
      await _users.insert(userModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signIn(
      {required String email, required String password, required BuildContext context}) async {
    try {
      await auth.signInWithPassword(email: email, password: password).then(
        (e) {
          showSnackBar(
            context,
            "loged In successfully",
          );
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => const ChatScreen()),
            ModalRoute.withName('/'),
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      log(e.toString());
      throw Failure(e.toString());
    }
  }

  static Stream<List<MessageModel>> getAllMessages() {
    var ref = _chat.stream(primaryKey: ['message_id']).order('created_at', ascending: false);
    return ref.map((chats) {
      List<MessageModel> messages = [];
      for (var chat in chats) {
        messages.add(MessageModel.fromMap(chat));
      }
      return messages;
    });
  }

  static Future<void> sendMessage(MessageModel message) async {
    try {
      await _chat.insert(message.toMap());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  static Future<void> deleteMessage(String message_id, BuildContext context) async {
    try {
      await _chat.delete().eq("message_id", message_id).then(
            (e) => showSnackBar(
              context,
              "Message Deleted successfully",
            ),
          );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  static Future<void> editMessage(
      MessageModel message, String message_id, BuildContext context) async {
    try {
      await _chat.update(message.toMap()).eq("message_id", message_id).then(
            (e) => showSnackBar(
              context,
              "Message Edited successfully",
            ),
          );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut().then((e) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => const StartScreen()));
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> getUserData(String user_id) async {
    try {
      UserModel? user;
      var ref = _users.select('*').eq("user_id", user_id).single().then((data) {
        user = data.isNotEmpty ? UserModel.fromMap(data) : null;
      });
      await ref;

      return user;
    } catch (e) {
      log(e.toString());
      throw Failure(e.toString());
    }
  }
}
