import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/order_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: Colors.grey[100], // AppConstColor.backgroundGray
      appBar: AppBar(title: const Text("Orders"), centerTitle: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeFilters(controller),
          Expanded(
            child: GetBuilder<OrderController>(
              builder: (ctrl) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ctrl.orders.length,
                  itemBuilder: (context, index) {
                    // Index pass kora hoyeche jate specific order update hoy
                    return _buildOrderCard(context, index, ctrl);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilters(OrderController controller) {
    return GetBuilder<OrderController>(
      builder: (ctrl) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),

          child: Row(
            children: ctrl.timeFilters.asMap().entries.map((entry) {
              bool isSelected = ctrl.selectedTimeIndex == entry.key;

              return Padding(
                padding: const EdgeInsets.only(right: 10),

                child: ChoiceChip(
                  label: Text(entry.value),

                  selected: isSelected,

                  onSelected: (_) => ctrl.setTimeFilter(entry.key),

                  selectedColor: AppConstColor.primaryColor,

                  backgroundColor: Colors.white,

                  // Icon color white korar jonno nichei line ti add kora hoyeche
                  checkmarkColor: Colors.white,

                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,

                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),

                  shape: const StadiumBorder(),

                  side: BorderSide.none,

                  // Jodi apni icon ti ekbarei soriye felte chan tobe 'showCheckmark: false' use korte paren
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    int index,
    OrderController controller,
  ) {
    final order = controller.orders[index];
    return GestureDetector(
      onTap: () {
        controller.tempSelectedStatus = order.status;
        _showStatusBottomSheet(context, index, controller);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, i) {
                final item = order.items[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: Image.asset(item.image, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("৳${item.price.toStringAsFixed(2)}"),
                              ],
                            ),
                            Text("Quantity: ${item.quantity}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery : ${order.deliveryLocation}"),
                  Text(
                    order.status,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 30, thickness: 1, color: Color(0xFFF1F1F1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total ${order.totalItemCount} items"),
                Text(
                  "৳${order.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusBottomSheet(
    BuildContext context,
    int orderIndex,
    OrderController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Change Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GetBuilder<OrderController>(
              builder: (ctrl) {
                return Column(
                  children: ctrl.orderStatuses.map((status) {
                    return RadioListTile<String>(
                      title: Text(status),
                      value: status,
                      groupValue: ctrl.tempSelectedStatus,
                      onChanged: (val) => ctrl.setTempStatus(val!),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.updateOrderStatus(orderIndex),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
