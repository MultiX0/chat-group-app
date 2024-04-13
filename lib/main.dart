import 'package:chat_group/view/auth/start_screen.dart';
import 'package:chat_group/view/home/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //add your database url and the anonymous key here:
  await Supabase.initialize(
    url: "SUPABASE_URL",
    anonKey: "SUPABASE_ANON_KEY",
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "- Chat Group -",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: supabase.auth.currentSession != null ? const ChatScreen() : const StartScreen(),
    );
  }
}
