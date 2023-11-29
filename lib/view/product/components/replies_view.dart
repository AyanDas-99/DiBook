import 'package:dibook/state/message/providers/get_replies_by_message_id.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepliesView extends ConsumerWidget {
  const RepliesView({super.key, required this.messageId});
  final String messageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replies = ref.watch(getRepliesByMessageIdProvider(messageId));
    return replies.when(
        data: (messages) {
          if (messages.isEmpty) {
            return Text("No replies");
          }
          return SizedBox(
              height: 100,
              child: ListView.builder(
                itemBuilder: (context, index) => Text(messages[index].message),
                itemCount: messages.length,
              ));
        },
        error: (e, _) => const Text("Couldn't load repies"),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
