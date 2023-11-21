import 'package:image_picker/image_picker.dart';

Future<List<String>> pickImages() async {
  final images = await ImagePicker().pickMultiImage();
  return images.map((e) => e.path).toList();
}

Future<String?> pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image?.path;
}
