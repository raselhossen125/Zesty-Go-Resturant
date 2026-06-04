import 'dart:async';
import 'package:get/get.dart';
import '../repository/order_repository.dart';
import '../ui_models/order_model.dart';

class OrderController extends GetxController {
  final OrderRepository _orderRepo = OrderRepository();
  StreamSubscription? _orderSubscription;

  List<OrderModel> allOrders = [];
  List<OrderModel> filteredOrders = [];
  bool isLoading = false;

  // Filter tabs
  final List<String> timeFilters = [
    "All Orders",
    "Pending",
    "Accepted",
    "Processing",
    "Delivered",
    "Cancelled",
  ];
  int selectedTimeIndex = 0;

  final List<String> orderStatuses = [
    "pending",
    "accepted",
    "processing",
    "delivered",
    "cancelled",
  ];

  String tempSelectedStatus = "";

  @override
  void onInit() {
    super.onInit();
    fetchLiveOrders();
  }

  // Live orders stream
  void fetchLiveOrders() {
    isLoading = true;
    update();

    _orderSubscription = _orderRepo.getOrdersStream().listen((ordersList) {
      allOrders = ordersList;
      _applyFilter();
      isLoading = false;
      update();
    });
  }

  // Change filter tab
  void setTimeFilter(int index) {
    selectedTimeIndex = index;
    _applyFilter();
    update();
  }

  // Apply selected filter
  void _applyFilter() {
    if (selectedTimeIndex == 0) {
      filteredOrders = allOrders;
    } else {
      String filterStatus = timeFilters[selectedTimeIndex].toLowerCase();
      filteredOrders = allOrders
          .where((order) => order.status.toLowerCase() == filterStatus)
          .toList();
    }
  }

  // Set status before update
  void setTempStatus(String status) {
    tempSelectedStatus = status;
    update();
  }

  // Update order status
  Future<void> updateOrderStatus(int index) async {
    if (filteredOrders.isEmpty || tempSelectedStatus.isEmpty) return;

    String targetOrderId = filteredOrders[index].orderId;

    try {
      Get.back();
      isLoading = true;
      update();

      await _orderRepo.updateOrderStatusInFirebase(
        targetOrderId,
        tempSelectedStatus,
      );

      Get.snackbar("Success", "Order status changed to '$tempSelectedStatus'.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    _orderSubscription?.cancel();
    super.onClose();
  }
}
