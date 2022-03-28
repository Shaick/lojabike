import 'package:get/get.dart';
import 'package:lojabike/app/controller/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersManager>(() => OrdersManager());
  }
}
