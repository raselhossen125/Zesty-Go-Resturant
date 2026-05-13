import 'package:get/get.dart';

// 1. Order Item Model
class OrderItem {
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}

// 2. Order Card/Model
class OrderModel {
  final String orderId;
  final List<OrderItem> items;
  final String deliveryLocation;
  String status;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.deliveryLocation,
    this.status = "Cooking",
  });

  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}

// 3. Main Order Controller
class OrderController extends GetxController {
  final List<String> timeFilters = ["Today", "This Week", "This Month", "All"];
  int selectedTimeIndex = 0;

  // UI er sathe match kore status list
  final List<String> orderStatuses = [
    "Cooking",
    "Ready",
    "Delivered",
    "Cancel",
  ];
  String tempSelectedStatus = "Cooking";

  List<OrderModel> orders = [
    OrderModel(
      orderId: "#1001",
      deliveryLocation: "Mirpur, Dhaka",
      status: "Cooking",
      items: [
        OrderItem(
          name: "Veggi Burger",
          price: 10.0,
          quantity: 4,
          image: "assets/image/burger.png",
        ),
        OrderItem(
          name: "Cheese Pizza",
          price: 25.0,
          quantity: 1,
          image: "assets/image/burger.png",
        ),
      ],
    ),
    OrderModel(
      orderId: "#1002",
      deliveryLocation: "Uttara, Dhaka",
      status: "Ready",
      items: [
        OrderItem(
          name: "Chicken Burger",
          price: 15.0,
          quantity: 2,
          image: "assets/image/burger.png",
        ),
      ],
    ),
  ];

  void setTimeFilter(int index) {
    selectedTimeIndex = index;
    update();
  }

  void setTempStatus(String status) {
    tempSelectedStatus = status;
    update();
  }

  void updateOrderStatus(int orderIndex) {
    orders[orderIndex].status = tempSelectedStatus;
    update();
    Get.back();
    Get.snackbar(
      "Success",
      "Order ${orders[orderIndex].orderId} status updated to $tempSelectedStatus",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
