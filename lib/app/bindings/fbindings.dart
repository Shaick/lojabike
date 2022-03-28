import 'package:get/get.dart';
import 'package:lojabike/app/controller/fcontroller.dart';

class FBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FController>(() => FController());
  }
}
