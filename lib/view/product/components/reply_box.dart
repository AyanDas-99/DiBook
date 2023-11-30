import 'package:dibook/state/message/providers/get_replies_by_message_id.dart';
import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReplyBox extends ConsumerWidget {
  ReplyBox(this.msgId, this.bookId, {super.key});
  final String msgId;
  final String bookId;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: DefaultTextField(
              controller: controller,
              placeHolder: "Reply",
            ),
          ),
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () async {
            await ref
                .read(uploadMessageNotifierProvider.notifier)
                .uploadMessage(
                  message: controller.text,
                  bookId: bookId,
                  context: context,
                  replyTo: msgId,
                );
            ref.invalidate(getRepliesByMessageIdProvider);
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
            "Send",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
