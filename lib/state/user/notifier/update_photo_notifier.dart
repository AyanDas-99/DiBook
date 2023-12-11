import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/update_user_notifier_provider.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/pick_images.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatePhotoNotifier extends StateNotifier<IsLoading> {
  UpdatePhotoNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future<bool> updateProfilePhoto(BuildContext context) async {
    isLoading = true;

    final user = ref.watch(userProvider);
    try {
      final imagePath = await pickImage();
      if (imagePath == null) {
        isLoading = false;
        return false;
      }

      // Uploading image to cloudinary
      final cloudinary = CloudinaryPublic('drrrtwtyf', 'qbpqcquc');
      CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(imagePath,
              folder: "Dibook/users/${user!.id}"));

      final imageUrl = res.secureUrl;

      // Update the user photoUrl
      if (context.mounted) {
        ref
            .read(updateUserNotifierProvider.notifier)
            .updateUser(context, photoUrl: imageUrl);
      }

      // Delete previous picture

      return true;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
      return false;
    } finally {
      isLoading = false;
    }
  }
}
