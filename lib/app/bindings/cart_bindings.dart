import 'package:get/get.dart';
import 'package:lojabike/app/controller/cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartManager>(() => CartManager());
  }
}
