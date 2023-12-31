import 'package:flutter/material.dart';

class TextAndIcon extends StatelessWidget {
  const TextAndIcon({
    super.key,
    required this.text,
    required this.icon,
    this.style,
    this.color,
    this.fontSize,
    this.iconSize,
    this.reversed = false,
    this.space,
  });
  final String text;
  final IconData icon;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final double? iconSize;
  final bool reversed;
  final double? space;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        text,
        style: style?.copyWith(color: color, fontSize: fontSize) ??
            TextStyle(color: color, fontSize: fontSize),
      ),
      SizedBox(width: space ?? 5),
      Icon(
        icon,
        size: iconSize,
        color: color,
      )
    ];
    if (reversed) {
      children = children.reversed.toList();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
