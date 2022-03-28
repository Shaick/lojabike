import 'package:get/get.dart';
import 'package:lojabike/app/controller/product_controller.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
