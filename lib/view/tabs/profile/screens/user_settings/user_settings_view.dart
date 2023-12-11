import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/tabs/profile/screens/user_settings/components/photo_section.dart';
import 'package:dibook/view/tabs/profile/screens/user_settings/components/second_section.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSettingsView extends ConsumerStatefulWidget {
  const UserSettingsView({super.key});

  @override
  ConsumerState<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends ConsumerState<UserSettingsView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final nameController = TextEditingController(text: user!.name);
    final addressController = TextEditingController(text: user.address);

    return Scaffold(
        appBar: customAppbar(context, leading: true, showSearchBar: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Heading(text: "User Settings"),
                ),
                const SizedBox(height: 20),
                const PhotoSection(),
                const SizedBox(height: 20),
                SecondSection(
                  nameController: nameController,
                  addressController: addressController,
                ),
              ],
            ),
          ),
        ));
  }
}
