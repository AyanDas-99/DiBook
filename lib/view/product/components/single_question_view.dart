import 'package:dibook/state/message/models/message.dart';
import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/view/components/string_dialog.dart';
import 'package:dibook/view/product/components/replies_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleQuestion extends ConsumerStatefulWidget {
  const SingleQuestion({super.key, required this.message});
  final Message message;

  @override
  ConsumerState<SingleQuestion> createState() => _SingleQuestionState();
}

class _SingleQuestionState extends ConsumerState<SingleQuestion> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message.message),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    open = !open;
                  });
                },
                child: Text(open ? "Hide replies" : "Show replies"),
              ),
              TextButton(
                onPressed: () async {
                  String? msg = await StringDialog.show(
                      context: context, content: "Enter your reply");
                  if (msg != null && msg.isNotEmpty) {
                    ref
                        .read(uploadMessageNotifierProvider.notifier)
                        .uploadMessage(
                          message: msg,
                          bookId: widget.message.bookId,
                          context: context,
                          replyTo: widget.message.messageId,
                        );
                  }
                },
                child: const Text("Reply"),
              )
            ],
          ),
          if (open) RepliesView(messageId: widget.message.messageId),
        ],
      ),
    );
  }
}
