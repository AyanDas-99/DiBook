import 'package:flutter/material.dart';

Future<int?> pickMonth(BuildContext context) async {
  const months = {
    "Jan": 1,
    "Feb": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "Aug": 8,
    "Sept": 9,
    "Oct": 10,
    "Nov": 11,
    "Dec": 12
  };

  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView(
        children: months.entries
            .map((e) => InkWell(
                  onTap: () => Navigator.of(context).pop(e.value),
                  child: ListTile(
                    title: Text(e.key),
                  ),
                ))
            .toList(),
      );
    },
  );
}
