import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/message/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final getRepliesByMessageIdProvider = FutureProvider.family
    .autoDispose<List<Message>, String>((ref, msgId) async {
  List<Message> replies = [];
  final res = await http.get(Uri.parse("${Constants.baseUrl}/$msgId/replies"));
  if (res.statusCode == 200) {
    replies.addAll(
        (jsonDecode(res.body) as List).map((e) => Message.fromMap(e)).toList());
  } else {
    throw Exception(res.body);
  }
  return replies;
});
