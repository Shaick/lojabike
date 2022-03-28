import 'package:get/get.dart';
import 'package:lojabike/app/data/model/cart_product_model.dart';

class CartProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartProduct>(() => CartProduct());
  }
}
