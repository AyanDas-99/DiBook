import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? color;
  const MainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              backgroundColor ?? ThemeConstants.mainYellow),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
                side: BorderSide(color: color ?? ThemeConstants.mainYellow)),
          ),
          minimumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 50))),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
