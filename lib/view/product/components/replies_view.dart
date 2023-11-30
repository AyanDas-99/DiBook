import 'dart:math';
import 'package:dibook/state/message/providers/get_replies_by_message_id.dart';
import 'package:dibook/view/components/text_and_icon.dart';
import 'package:dibook/view/product/components/reply_box.dart';
import 'package:dibook/view/product/components/seller_flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepliesView extends ConsumerStatefulWidget {
  const RepliesView(
      {super.key,
      required this.messageId,
      required this.sellerId,
      required this.bookId});
  final String messageId;
  final String sellerId;
  final String bookId;

  @override
  ConsumerState<RepliesView> createState() => _RepliesViewState();
}

class _RepliesViewState extends ConsumerState<RepliesView> {
  int limit = 5;
  @override
  Widget build(BuildContext context) {
    final replies = ref.watch(getRepliesByMessageIdProvider(widget.messageId));
    return Column(
      children: [
        ReplyBox(widget.messageId, widget.bookId),
        replies.when(
            data: (messages) {
              return Column(children: [
                if (messages.isEmpty) const Text("No replies"),
                ...List.generate(
                    min(messages.length, limit),
                    (index) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextAndIcon(
                                    text: messages[index].userName,
                                    icon: FontAwesomeIcons.user,
                                    iconSize: 12,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    reversed: true,
                                  ),
                                  if (widget.sellerId == messages[index].userId)
                                    sellerFlag(),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                messages[index].message,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        )),
                if (messages.length > 5)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          if (limit < messages.length) {
                            limit += 5;
                          } else {
                            limit = 5;
                          }
                        });
                      },
                      child: Text((messages.length <= limit)
                          ? "Show less"
                          : "Show more"))
              ]);
            },
            error: (e, _) => const Text("Couldn't load repies"),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ))
      ],
    );
  }
}

    // return ;