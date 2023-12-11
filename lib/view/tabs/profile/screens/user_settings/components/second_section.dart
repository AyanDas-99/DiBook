import 'package:dibook/state/user/provider/update_user_notifier_provider.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/components/default_textfield.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/tabs/profile/screens/user_settings/components/edit_indicator.dart';
import 'package:dibook/view/tabs/profile/screens/user_settings/components/tick_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecondSection extends ConsumerStatefulWidget {
  const SecondSection(
      {super.key,
      required this.nameController,
      required this.addressController});
  final TextEditingController nameController;
  final TextEditingController addressController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<SecondSection> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    bool sameValue = user!.name.trim() == widget.nameController.text.trim() &&
        user.address.trim() == widget.addressController.text.trim();

    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Name"),
                          const Spacer(),
                          Flexible(
                              flex: 3,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(width: 0.3))),
                                  child: DefaultTextField(
                                    controller: widget.nameController,
                                    onChange: (value) {
                                      setState(() {});
                                    },
                                  ))),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Text("Address"),
                          const Spacer(),
                          Flexible(
                              flex: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.3)),
                                  child: DefaultTextField(
                                      onChange: (value) {
                                        setState(() {});
                                      },
                                      controller: widget.addressController))),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            if (sameValue) const TickIndicator(),
            if (!sameValue) const EditIndicator(),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: 200,
            child: MainButton(
                text: "Confirm",
                onPressed: sameValue
                    ? null
                    : () {
                        ref
                            .read(updateUserNotifierProvider.notifier)
                            .updateUser(
                              context,
                              name: widget.nameController.text,
                              address: widget.addressController.text,
                            );
                      })),
      ],
    );
  }
}
