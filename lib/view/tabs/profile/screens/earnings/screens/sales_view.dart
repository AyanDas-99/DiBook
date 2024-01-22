import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/tabs/profile/screens/earnings/components/all_time_sales.dart';
import 'package:dibook/view/tabs/profile/screens/earnings/components/gross_sales.dart';
import 'package:dibook/view/tabs/profile/screens/earnings/components/this_year_sales.dart';
import 'package:flutter/material.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context,
          showAddress: false, showSearchBar: false, leading: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GrossSales(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ThisYearSales(), AllTimeSales()],
              )
            ],
          ),
        ),
      ),
    );
  }
}
