import 'dart:convert';

import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void httpErrorHandler({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
    case 409:
      showSnackBar(context, jsonDecode(response.body)['error']);

    default:
      showSnackBar(context, jsonDecode(response.body));
  }
}
