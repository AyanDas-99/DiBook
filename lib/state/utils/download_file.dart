import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadFile(String url) async {
  var path = await getDownloadsDirectory();
  path ??= await getApplicationDocumentsDirectory();

  url = url.replaceAll('''"''', '');
  final taskId = await FlutterDownloader.enqueue(
    url: url,
    headers: {},
    savedDir: path.path,
    saveInPublicStorage: true,
    showNotification: true,
    openFileFromNotification: true,
  );

  return taskId;
}
