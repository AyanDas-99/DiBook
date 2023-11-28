import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';

class DescriptionSection extends StatefulWidget {
  const DescriptionSection(this.description, {super.key});
  final String description;

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(text: "Seller's Description", sub: true),
            const SizedBox(height: 5),
            Wrap(
              children: [
                Text(open
                    ? widget.description
                    : widget.description.shorten(200)),
                if (widget.description.length > 200)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        open = !open;
                      });
                    },
                    child: Text(open ? "Show less" : "Show more"),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
