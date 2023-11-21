import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionBox({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.white,
      child: TextFormField(
        maxLines: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Description cannot be empty";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            hintText: Strings.desctiption,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(5)),
      ),
    );
  }
}
