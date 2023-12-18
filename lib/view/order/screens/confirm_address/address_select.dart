import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressSelect extends ConsumerStatefulWidget {
  const AddressSelect({required this.controller, super.key});
  final TextEditingController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddressSelectState();
}

class _AddressSelectState extends ConsumerState<AddressSelect> {
  bool custom = false;

  @override
  Widget build(BuildContext context) {
    final address = ref.watch(userProvider)!.address;
    if (!custom) {
      widget.controller.clear();
    }

    return Column(
      children: [
        Row(
          children: [
            Radio<bool>(
              value: false,
              groupValue: custom,
              onChanged: (bool? val) {
                setState(() {
                  custom = val!;
                });
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.4,
                        color: custom ? Colors.grey : Colors.black)),
                padding: const EdgeInsets.all(15),
                child: Text(
                  address.shorten(70),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: custom,
              onChanged: (bool? val) {
                setState(() {
                  custom = val!;
                });
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                maxLines: 5,
                minLines: 1,
                // expands: true,
                enabled: custom,
                controller: widget.controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ],
        )
      ],
    );
  }
}
