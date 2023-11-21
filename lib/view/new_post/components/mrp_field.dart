import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';

class MrpField extends StatelessWidget {
  const MrpField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      controller: controller,
      placeHolder: Strings.mrp,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "MRP cannot be empty";
        } else if (int.parse(value).isNegative || int.parse(value) == 0) {
          return "MRP can only be a positive number";
        }
        return null;
      },
    );
  }
}
