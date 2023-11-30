import 'dart:math';

import 'package:dibook/state/message/providers/get_messages_by_book_id.dart';
import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/text_and_icon.dart';
import 'package:dibook/view/product/components/single_question_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsSection extends ConsumerStatefulWidget {
  const QuestionsSection(
      {super.key, required this.bookId, required this.sellerId});
  final String bookId;
  final String sellerId;

  @override
  ConsumerState<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends ConsumerState<QuestionsSection> {
  final controller = TextEditingController();
  bool show = false;
  int limit = 3;

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(getMessagesByBookIdProvider(widget.bookId));
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
                        bookId: widget.bookId,
                        context: context);
                ref.invalidate(getMessagesByBookIdProvider);
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
        questions.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text("No questions asked yet!"),
                  ),
                );
              }
              return Column(children: [
                ...List.generate(
                    min(messages.length, limit),
                    (index) => SingleQuestion(
                          message: messages[index],
                          sellerId: widget.sellerId,
                        )),
                if (messages.length > 5)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          if (limit < messages.length) {
                            limit += 3;
                          } else {
                            limit = 3;
                          }
                        });
                      },
                      child: Text((messages.length <= limit)
                          ? "Show less"
                          : "Show more"))
              ]);
            },
            error: (e, _) => TextButton(
                onPressed: () {
                  ref.invalidate(getMessagesByBookIdProvider);
                },
                child: const TextAndIcon(
                  text: "Retry",
                  icon: FontAwesomeIcons.rotate,
                )),
            loading: () => const Center(child: CircularProgressIndicator())),
      ],
    );
  }
}
