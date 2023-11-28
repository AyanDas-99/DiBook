// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/message/strings/message_key.dart';

class MessagePayload {
  final String bookId;
  final String userName;
  final String replyTo;
  final String message;

  MessagePayload(
      {required this.bookId,
      required this.userName,
      required this.replyTo,
      required this.message});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Messagekeys.bookId: bookId,
      Messagekeys.userName: userName,
      Messagekeys.replyTo: replyTo,
      Messagekeys.msg: message,
    };
  }

  String toJson() => json.encode(toMap());
}
