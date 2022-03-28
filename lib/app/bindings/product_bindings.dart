import 'package:get/get.dart';
import 'package:lojabike/app/data/model/item_size_model.dart';
import 'package:lojabike/app/data/model/product_model.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Product>(() =>
        Product(sizes: [ItemSize(name: '', pricea: 0, pricev: 0, stock: 0)]));
  }
}
