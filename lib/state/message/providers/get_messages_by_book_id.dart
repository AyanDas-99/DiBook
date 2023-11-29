import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/message/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final getMessagesByBookIdProvider = FutureProvider.family
    .autoDispose<List<Message>, String>((ref, bookId) async {
  List<Message> messages = [];
  final res =
      await http.get(Uri.parse("${Constants.baseUrl}/$bookId/messages"));
  if (res.statusCode == 200) {
    messages.addAll(
        (jsonDecode(res.body) as List).map((e) => Message.fromMap(e)).toList());
  } else {
    throw Exception(res.body);
  }
  return messages;
});
