import 'package:dibook/state/order/constants/order_status.dart';
import 'package:dibook/view/tabs/profile/screens/orders/components/my_timeline_tile.dart';
import 'package:flutter/material.dart';

class OrderStatusView extends StatefulWidget {
  const OrderStatusView(this.status, {super.key});
  final OrderStatus status;

  @override
  State<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  @override
  Widget build(BuildContext context) {
    int statusLevel = getStatusLevel();
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyTimelineTile(
            first: true,
            image: "asset/images/box.png",
            title: statusLevel == 0 ? "Not Dispatched" : "Dispatched",
            done: statusLevel > 0,
          ),
          MyTimelineTile(
            title: "Reached Station",
            image: statusLevel > 1 ? "asset/images/flag.png" : null,
            done: statusLevel > 1,
          ),
          MyTimelineTile(
            last: true,
            image: statusLevel == 3 ? "asset/images/delivered.png" : null,
            title: "Delivered",
            done: statusLevel == 3,
          ),
        ],
      ),
    );
  }

  int getStatusLevel() {
    if (widget.status == OrderStatus.notDispatched) {
      return 0;
    } else if (widget.status == OrderStatus.dispatched) {
      return 1;
    } else if (widget.status == OrderStatus.reached) {
      return 2;
    }
    return 3;
  }
}
