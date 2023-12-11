import 'package:dibook/state/user/provider/update_photo_notifier_provider.dart';
import 'package:dibook/state/user/provider/update_user_notifier_provider.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhotoSection extends ConsumerStatefulWidget {
  const PhotoSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoSectionState();
}

class _PhotoSectionState extends ConsumerState<PhotoSection> {
  bool emptyPhoto = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Column(
      children: [
        if (emptyPhoto)
          ClipOval(
            child: Container(
              height: 150,
              width: 150,
              color: Colors.blueGrey.shade100,
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.ban,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        if (!emptyPhoto)
          GestureDetector(
            onTap: () {
              ref
                  .read(updatePhotoProvider.notifier)
                  .updateProfilePhoto(context);
            },
            child: ClipOval(
              child: (user!.photoUrl.isEmpty)
                  ? Container(
                      height: 150,
                      width: 150,
                      color: Colors.blueGrey.shade100,
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  : SizedBox.fromSize(
                      size: const Size.fromRadius(
                        80,
                      ),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage("asset/gif/shimmer.gif"),
                        image: NetworkImage(user.photoUrl),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset("asset/images/image_error.png"),
                      ),
                    ),
            ),
          ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("No profile picture"),
          const SizedBox(width: 10),
          Switch(
              thumbColor: const MaterialStatePropertyAll(Colors.white),
              trackColor: MaterialStatePropertyAll(ThemeConstants.darkGreen),
              value: emptyPhoto,
              onChanged: (bool value) {
                setState(() {
                  emptyPhoto = value;
                });
                if (value == true) {
                  ref
                      .read(updateUserNotifierProvider.notifier)
                      .updateUser(context, photoUrl: "");
                }
              })
        ])
      ],
    );
  }
}
