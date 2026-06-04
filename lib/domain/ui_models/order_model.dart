import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String id;
  final String image;
  final String name;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 0).toInt(),
    );
  }
}

class OrderModel {
  final String orderId;
  final String status;
  final double totalAmount;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final String paymentMethod;
  final String userName;
  final String userEmail;
  final String deliveryAddress;
  final String phone;
  final Timestamp? createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.paymentMethod,
    required this.userName,
    required this.userEmail,
    required this.deliveryAddress,
    required this.phone,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    var itemsList = map['items'] as List? ?? [];
    List<OrderItemModel> parsedItems = itemsList
        .map((item) => OrderItemModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();

    // nested deliveryAddress map handling
    var addressMap = map['deliveryAddress'] as Map? ?? {};

    return OrderModel(
      orderId: id,
      status: map['status'] ?? 'pending',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      deliveryFee: (map['deliveryFee'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? 'cash',
      userName: map['userName'] ?? 'Guest User',
      userEmail: map['userEmail'] ?? '',
      deliveryAddress: addressMap['address'] ?? 'No Address',
      phone: addressMap['phone'] ?? '',
      createdAt: map['createdAt'] as Timestamp?,
      items: parsedItems,
    );
  }
}
