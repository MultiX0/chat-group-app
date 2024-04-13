// ignore_for_file: prefer_const_declarations, unused_local_variable

import 'package:flutter/material.dart';

import '../../core/common/sign_in_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final isLoading = false;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Chat Group',
            style: TextStyle(
              fontSize: 55,
              fontFamily: "LobsterTwo",
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Welcome! Join the conversation and connect with others. Let's chat!",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const SignInButton(
            text: "Register",
            isLogin: false,
            color: Color.fromARGB(202, 135, 88, 255),
          ),
          const SignInButton(
            text: "Login",
            isLogin: true,
            color: Color(0xff242424),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
