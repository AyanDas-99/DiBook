import 'package:dibook/view/auth/constants/strings.dart';
import 'package:dibook/view/components/defaultTextField.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the name";
        } else if (value.length < 5) {
          return "Password must be 5 characters or long";
        }
        return null;
      },
      controller: controller,
      placeHolder: Strings.password,
    );
  }
}
