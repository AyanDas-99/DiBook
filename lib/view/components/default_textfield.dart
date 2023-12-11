import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? placeHolder;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  const DefaultTextField({
    super.key,
    required this.controller,
    this.validator,
    this.placeHolder,
    this.keyboardType,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.white,
      child: TextFormField(
        onChanged: onChange,
        minLines: 1,
        maxLines: 5,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: placeHolder,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(5)),
      ),
    );
  }
}
