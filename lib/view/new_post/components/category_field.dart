import 'package:dibook/view/new_post/strings.dart';
import 'package:dibook/view/constants/strings.dart' as global;
import 'package:flutter/material.dart';

class CategoryField extends StatefulWidget {
  const CategoryField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  String fieldValue = "";

  @override
  void initState() {
    fieldValue = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: DropdownButtonFormField(
        hint: Text(Strings.selectCategory),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Select a category";
          }
          return null;
        },
        value: fieldValue.isNotEmpty ? fieldValue : null,
        items: global.Strings.categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  key: Key(e),
                  child: Text(e),
                ))
            .toList(),
        onChanged: (a) {
          setState(() {
            fieldValue = a!;
            widget.controller.text = a;
          });
        },
      ),
    );
  }
}
