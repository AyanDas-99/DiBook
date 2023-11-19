import 'package:dibook/view/auth/constants/strings.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter the name";
        } else if (!EmailValidator.validate(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      controller: controller,
      placeHolder: Strings.email,
    );
  }
}
