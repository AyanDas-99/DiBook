// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/message/strings/message_key.dart';

class Message {
  final String messageId;
  final String message;
  final String bookId;
  final String userId;
  final String userName;
  final String replyTo;
  final DateTime createdAt;

  Message(
      {required this.messageId,
      required this.message,
      required this.bookId,
      required this.userId,
      required this.userName,
      required this.replyTo,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'message': message,
      'bookId': bookId,
      'userId': userId,
      'userName': userName,
      'replyTo': replyTo,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map[Messagekeys.msgId],
      message: map[Messagekeys.msg],
      bookId: map[Messagekeys.bookId],
      userId: map[Messagekeys.userId],
      userName: map[Messagekeys.userName],
      replyTo: map[Messagekeys.replyTo],
      createdAt: DateTime.parse(map[Messagekeys.createdAt]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
