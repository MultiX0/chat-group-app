import 'package:chat_group/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/hex2color.dart';

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({
    super.key,
    required this.text,
    this.maxLenght = 40,
    this.isPassword = false,
    this.autoFocus = false,
    this.keyboardType = TextInputType.emailAddress,
    required this.controller,
    required this.inputFormatters,
    required this.validator,
  });
  final String text;
  final int maxLenght;
  final bool isPassword;
  final bool autoFocus;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  bool _passwordVisible = false;
  String? _errorText;

  void _validateInput(String value) {
    setState(() {
      _errorText = widget.validator!(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height / 17,
          child: TextFormField(
            onChanged: _validateInput,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.isPassword ? !_passwordVisible : false,
            enableSuggestions: widget.isPassword,
            autocorrect: widget.isPassword,
            obscuringCharacter: "●",
            autofocus: widget.autoFocus,
            inputFormatters: widget.inputFormatters,
            keyboardType: TextInputType.emailAddress,
            maxLength: widget.maxLenght,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            cursorColor: AppColors.buttonPrimary,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 0, height: 0.001),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: size.height / 50, horizontal: 16),
              focusColor: HexColor.fromHex("#1E1F21"),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              counterText: '',
              hintText: widget.text,
              hintStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white60,
                fontWeight: FontWeight.w400,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              labelStyle: TextStyle(
                  color: HexColor.fromHex("#959AA3"), fontSize: 16, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: HexColor.fromHex("#1E1F21"),
              labelText: widget.text,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.buttonPrimary,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 5),
        _errorText != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _errorText.toString(),
                  style: const TextStyle(fontSize: 13, color: Colors.red),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
