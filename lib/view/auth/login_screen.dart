import 'package:chat_group/api/supabase_api.dart';
import 'package:chat_group/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/common/big_button_widget..dart';
import '../../core/common/leading_back_button.dart';
import '../../widget/input_form_widget.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void validateAndSave(BuildContext context) {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      API.signIn(email: email.text.trim(), password: password.text.trim(), context: context);
    }
  }

  RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        email.clear();
        password.clear();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                LeadingBackButton(
                  func: () {
                    email.clear();
                    password.clear();
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    const Text("Welcome back!",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w800, fontFamily: "FixelDisplay")),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "We're so excited to see you again!",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary),
                      // textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 5.5,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ACCOUNT INFORMATION",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                InputFormWidget(
                                  text: "Email",
                                  controller: email,
                                  isPassword: false,
                                  validator: (value) {
                                    if (!emailRegex.hasMatch(value!)) {
                                      return 'Email are invalid!';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r"\s"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputFormWidget(
                                  text: "Password",
                                  controller: password,
                                  isPassword: true,
                                  maxLenght: 72,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password can\'t be empty!';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters long!';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(r"\s"))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            // TODO: should be link to reset password
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: AppColors.link,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            BigButtonWidget(
                              text: "Log In",
                              isLoading: isLoading,
                              height: size.height / 19,
                              onPressed: () => validateAndSave(context),
                              backgroundColor: AppColors.buttonPrimary,
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
