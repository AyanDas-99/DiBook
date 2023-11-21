import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  const NameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      controller: controller,
      placeHolder: Strings.nameOfBook,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name cannont be empty";
        }
        return null;
      },
    );
  }
}
