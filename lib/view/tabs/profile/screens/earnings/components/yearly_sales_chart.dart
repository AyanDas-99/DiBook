import 'package:dibook/state/sales/providers/all_sales_by_date_range_provider.dart';
import 'package:dibook/state/sales/utils/calculate_total.dart';
import 'package:dibook/state/sales/utils/total_books_sold.dart';
import 'package:dibook/state/sales/utils/total_sale_on_month.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/text_and_icon.dart';
import 'package:dibook/view/tabs/profile/screens/earnings/components/year_picker_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YearlySalesChart extends ConsumerStatefulWidget {
  const YearlySalesChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _YearlySalesChartState();
}

class _YearlySalesChartState extends ConsumerState<YearlySalesChart> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    const months = {
      "Jan": 1,
      "Feb": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "Aug": 8,
      "Sept": 9,
      "Oct": 10,
      "Nov": 11,
      "Dec": 12
    };

    final sales = ref.watch(allSalesByYearProvider(selectedYear));
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Heading(text: "Yearly Sales", sub: true),
                  ),

                  // Year Selector
                  ElevatedButton(
                    onPressed: () async {
                      int? year = await pickYear(context);
                      if (year != null) {
                        setState(() {
                          selectedYear = year;
                        });
                      }
                    },
                    child: TextAndIcon(
                      text: selectedYear.toString(),
                      icon: FontAwesomeIcons.angleDown,
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Graph
            sales.when(
                data: (sales) => AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                                spots: months.entries
                                    .map((e) => FlSpot(
                                        e.value.toDouble(),
                                        totalSaleOnMonth(sales, e.value)
                                            .toDouble()))
                                    .toList())
                          ],
                          titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                            interval: 2,
                            showTitles: true,
                            getTitlesWidget: (value, meta) => Text(months.keys
                                .firstWhere(
                                    (element) => months[element] == value)),
                          ))))),
                    ),
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator()),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ...sales.when(
              data: (sales) => [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Number of books sold on $selectedYear: ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(totalBooksSold(sales).toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Total sale on $selectedYear: ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text("\u{20B9} ${calculateTotal(sales)}"),
                    ],
                  ),
                )
              ],
              error: (e, st) => [Text(e.toString())],
              loading: () => [const CircularProgressIndicator()],
            ),
          ],
        ),
      ),
    );
  }
}
