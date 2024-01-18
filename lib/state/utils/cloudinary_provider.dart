import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Cloudinary singleton class
// Initiates cloudinary
class CloudinaryProvider {
  static final CloudinaryProvider _cloudinaryProvider =
      CloudinaryProvider.internal();
  final Cloudinary cloudinary = Cloudinary.unsignedConfig(
    cloudName: dotenv.env['CLOUDINARY_CLOUD_NAME']!,
  );

  factory CloudinaryProvider() => _cloudinaryProvider;
  CloudinaryProvider.internal();
}
