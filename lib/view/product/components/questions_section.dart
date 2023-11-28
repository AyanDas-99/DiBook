import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsSection extends ConsumerWidget {
  QuestionsSection(
      {super.key, required this.bookId, required this.parentContext});
  final String bookId;
  final BuildContext parentContext;

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
              onPressed: () async {
                await ref
                    .read(uploadMessageNotifierProvider.notifier)
                    .uploadMessage(
                        message: controller.text,
                        bookId: bookId,
                        context: context);
              },
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
        const RoundedContainer(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text("No questions asked yet!"),
            ),
          ),
        ),
      ],
    );
  }
}
