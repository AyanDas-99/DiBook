import 'package:dibook/state/message/providers/get_messages_by_book_id.dart';
import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/components/replies_view.dart';
import 'package:dibook/view/product/components/single_question_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsSection extends ConsumerStatefulWidget {
  QuestionsSection({super.key, required this.bookId});
  final String bookId;

  @override
  ConsumerState<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends ConsumerState<QuestionsSection> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Building...");
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
        SizedBox(
          height: 300,
          child: RoundedContainer(
            child: questions.when(
                data: (messages) {
                  if (messages.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("No questions asked yet!"),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return SingleQuestion(message: messages[index]);
                      });
                },
                error: (e, _) => Text(e.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ),
        ),
      ],
    );
  }
}
