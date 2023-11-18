import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? placeHolder;
  final TextEditingController controller;
  const DefaultTextField({
    super.key,
    required this.controller,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.white,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: placeHolder,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(5)),
      ),
    );
  }
}
