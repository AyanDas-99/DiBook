import 'package:dibook/state/sales/models/sale.dart';
import 'package:dibook/state/sales/providers/all_sales_by_year_provider.dart';
import 'package:dibook/state/sales/providers/all_sales_provider.dart';
import 'package:dibook/state/sales/utils/calculate_total.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GrossSales extends ConsumerStatefulWidget {
  const GrossSales({super.key});

  @override
  ConsumerState<GrossSales> createState() => _GrossSalesState();
}

class _GrossSalesState extends ConsumerState<GrossSales>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late int selectedYear;
  late AsyncValue<List<Sale>> sales = ref.watch(allSalesProvider);

  final GlobalKey<TooltipState> toolTipKey = GlobalKey<TooltipState>();

  @override
  void initState() {
    selectedYear = DateTime.now().year;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = IntTween(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  void animate(int total) {
    _controller.reset();
    _animation = StepTween(begin: 0, end: total, step: 5000)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _controller.forward();
  }

  void goBack() {
    setState(() {
      selectedYear = selectedYear - 1;
    });
  }

  void goForward() {
    setState(() {
      selectedYear = selectedYear + 1;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sales = ref.watch(allSalesByYearProvider(selectedYear));
    return SizedBox(
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // Go back year
                  goBack();
                },
                icon: const FaIcon(FontAwesomeIcons.angleLeft, size: 20),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  selectedYear == DateTime.now().year
                      ? "This Year"
                      : selectedYear.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: selectedYear < DateTime.now().year
                    ? () {
                        // Go forward year
                        goForward();
                      }
                    : null,
                icon: const FaIcon(FontAwesomeIcons.angleRight, size: 20),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.blueGrey.shade100,
                    spreadRadius: 0.5)
              ],
            ),
            child: CircleAvatar(
              radius: 110,
              backgroundColor: Colors.white,
              child: sales.when(
                  data: (sales) {
                    if (sales.isNotEmpty) {
                      int totalSales = calculateTotal(sales);
                      animate(totalSales);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Text(
                                  "\u{20B9}${_animation.value}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.green.shade700),
                                );
                              }),
                          const Text(
                            "Total Sales",
                            style:
                                TextStyle(fontSize: 15, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 10),
                          Tooltip(
                            key: toolTipKey,
                            height: 80,
                            message:
                                "${sales.length} book sold on $selectedYear",
                            textStyle: const TextStyle(color: Colors.black),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                    spreadRadius: 0.3)
                              ],
                              // border: Border.all(width: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Show no. of sales or something
                                  toolTipKey.currentState!
                                      .ensureTooltipVisible();
                                },
                                child: const Text("Details")),
                          )
                        ],
                      );
                    } else {
                      return const Text("No Sales");
                    }
                  },
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

class StepTween extends Tween<int> {
  final int step;

  StepTween({required int begin, required int end, required this.step})
      : super(begin: begin, end: end);

  @override
  int lerp(double t) {
    return (begin! + (end! - begin!) * t).roundToDouble().toInt();
  }
}
