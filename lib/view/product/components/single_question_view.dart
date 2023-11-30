import 'package:dibook/state/message/models/message.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/text_and_icon.dart';
import 'package:dibook/view/product/components/replies_view.dart';
import 'package:dibook/view/product/components/reply_box.dart';
import 'package:dibook/view/product/components/seller_flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleQuestion extends ConsumerStatefulWidget {
  const SingleQuestion(
      {super.key, required this.message, required this.sellerId});
  final Message message;
  final String sellerId;

  @override
  ConsumerState<SingleQuestion> createState() => _SingleQuestionState();
}

class _SingleQuestionState extends ConsumerState<SingleQuestion> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextAndIcon(
                    text: widget.message.userName,
                    icon: FontAwesomeIcons.user,
                    iconSize: 15,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    reversed: true,
                  ),
                  if (widget.sellerId == widget.message.userId) sellerFlag(),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.message.message,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    open = !open;
                  });
                },
                child: TextAndIcon(
                  iconSize: 13,
                  fontSize: 13,
                  color: Colors.indigo,
                  icon: (open)
                      ? FontAwesomeIcons.caretUp
                      : FontAwesomeIcons.caretDown,
                  text: "Replies",
                ),
              ),
              if (open)
                RepliesView(
                  messageId: widget.message.messageId,
                  sellerId: widget.sellerId,
                  bookId: widget.message.bookId,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
