import 'dart:io';
import 'dart:typed_data';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getDownloadsDirectory();

  return directory!.path;
}

Future<File> _localFile(String name) async {
  final path = await _localPath;
  return File('$path/$name.pdf');
}

Future saveToDocuments(Uint8List pdf, String name, BuildContext context) async {
  final file = await _localFile(name);
  await file.create(recursive: true);
  await file.writeAsBytes(pdf);
  if (context.mounted) {
    showSnackBar(context, "Downloaded PDF at ${file.path}");
  }
}
