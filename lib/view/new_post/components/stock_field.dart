import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';

class StockField extends StatelessWidget {
  const StockField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: false),
      controller: controller,
      placeHolder: Strings.stock,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "stock cannont be empty";
        } else if (int.parse(value).isNegative || int.parse(value) == 0) {
          return "stock can only be a positive whole number";
        }
        return null;
      },
    );
  }
}
