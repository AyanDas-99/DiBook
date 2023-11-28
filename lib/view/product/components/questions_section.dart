import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsSection extends ConsumerWidget {
  QuestionsSection({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Heading(
            text: "Ask Questions",
            sub: true,
          ),
        ),
        Row(
          children: [
            Expanded(
                child: DefaultTextField(
              controller: controller,
              placeHolder: "Write your question",
            )),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(EdgeInsets.all(22)),
                backgroundColor:
                    MaterialStatePropertyAll(ThemeConstants.lightGreen),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        RoundedContainer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text("No questions asked yet!"),
            ),
          ),
        ),
      ],
    );
  }
}
