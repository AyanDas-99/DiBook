import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';

class CategoryField extends StatefulWidget {
  CategoryField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  String value = "";

  final List<String> categories = [
    "School",
    "Engineering",
    "Literature",
    "Medical",
    "Economy",
    "Entrance Exam",
    "Biography"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: DropdownMenu(
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none),
        hintText: Strings.selectCategory,
        controller: widget.controller,
        dropdownMenuEntries: categories
            .map((category) => DropdownMenuEntry(
                  value: category,
                  label: category,
                ))
            .toList(),
        onSelected: (a) {
          setState(() {
            value = a!;
          });
        },
      ),
    );
  }
}
