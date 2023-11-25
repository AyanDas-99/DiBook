import 'package:dibook/view/components/default_textfield.dart';
import 'package:flutter/material.dart';

class MissingPagesField extends StatelessWidget {
  const MissingPagesField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: false),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Cannot be empty";
        } else if (int.parse(value).isNegative) {
          return "Can only be a positive number";
        }
        return null;
      },
    );
  }
}
