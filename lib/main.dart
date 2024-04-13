import 'package:chat_group/view/auth/start_screen.dart';
import 'package:chat_group/view/home/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vlwmrflauftwssusihwv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZsd21yZmxhdWZ0d3NzdXNpaHd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI5OTA3NDksImV4cCI6MjAyODU2Njc0OX0.MXYVjtikOnUBknL8lftpZMsL75gSWMjd1ilbFV6IASs',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Group",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: supabase.auth.currentSession != null ? const ChatScreen() : const StartScreen(),
    );
  }
}
