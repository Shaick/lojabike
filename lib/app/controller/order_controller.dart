import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/data/model/order_model.dart';

class OrdersManager extends GetxController {
  List<Order> orders = [];
  StreamSubscription? subscription;
  @override
  void onInit() {
    _listenToOrders();
    super.onInit();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _listenToOrders() {
    subscription = firestore.collection('orders').snapshots().listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }
      update();
      print(orders);
    });
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
