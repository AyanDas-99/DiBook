import 'package:dibook/state/sales/providers/all_sales_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(allSalesProvider);
    return Scaffold(
        appBar: customAppbar(context,
            showSearchBar: false, leading: true, showAddress: false),
        body: sales.when(
            data: (sales) {
              return SingleChildScrollView(
                child: Column(
                  children: sales.map((e) => Text(e.id)).toList(),
                ),
              );
            },
            error: (e, st) => Center(
                  child: Text(e.toString()),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
