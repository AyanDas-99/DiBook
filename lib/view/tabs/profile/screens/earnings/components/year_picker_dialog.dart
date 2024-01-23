import 'package:flutter/material.dart';

Future<int?> pickYear(BuildContext context) async {
  DateTime? selected;
  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return YearPicker(
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year),
        selectedDate: selected,
        onChanged: (DateTime dateTime) {
          Navigator.of(context).pop(dateTime.year);
        },
      );
    },
  );
}
