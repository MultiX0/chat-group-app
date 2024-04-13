import 'package:chat_group/view/auth/login_screen.dart';
import 'package:chat_group/view/auth/register_screen.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final bool isLogin;
  final Color color;
  const SignInButton({super.key, required this.text, required this.isLogin, required this.color});

  void authMethod(BuildContext context) {
    if (isLogin) {
      // ref.read(authControllerProvider.notifier).signInWithGoogle(context);
      // context.push("/sigin");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      // context.push("/register");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: ElevatedButton.icon(
        onPressed: () => authMethod(context),
        label: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300]!,
              fontFamily: "FixelText",
              fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
