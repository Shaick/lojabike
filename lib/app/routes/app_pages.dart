import 'package:get/get.dart';
import 'package:lojabike/app/bindings/cart_bindings.dart';
import 'package:lojabike/app/bindings/cart_product_bidings.dart';
import 'package:lojabike/app/bindings/fbindings.dart';
import 'package:lojabike/app/bindings/login_bindings.dart';
import 'package:lojabike/app/bindings/order_bindings.dart';
import 'package:lojabike/app/bindings/product_bindings.dart';
import 'package:lojabike/app/bindings/products_bindings.dart';
import 'package:lojabike/app/views/cad_fornecedor.dart';
import 'package:lojabike/app/views/cart_page.dart';
import 'package:lojabike/app/views/checkout_page.dart';
import 'package:lojabike/app/views/fornecedores_page.dart';
import 'package:lojabike/app/views/home_page.dart';
import 'package:lojabike/app/views/login_page.dart';
import 'package:lojabike/app/views/order_page.dart';
import 'package:lojabike/app/views/product_edit_page.dart';
import 'package:lojabike/app/views/product_page.dart';
import 'package:lojabike/app/views/products_page.dart';
import 'package:lojabike/app/views/signup_page.dart';
import 'package:lojabike/app/views/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => InitialPage()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.SIGNUP, page: () => SignupPage(), binding: LoginBinding()),
    GetPage(name: Routes.HOMEPAGE, page: () => HomePage(), binding: FBinding()),
    GetPage(
        name: Routes.CADFORNECEDOR,
        page: () => CarFornecedor(),
        binding: FBinding()),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutPage(),
      //binding: FBinding(),
    ),
    GetPage(
        name: Routes.FORNECEDORES,
        page: () => FornecedoresPage(),
        binding: FBinding()),
    GetPage(
        name: Routes.ORDER, page: () => OrderPage(), binding: OrderBinding()),
    GetPage(name: Routes.PRODUCTS, page: () => ProductsPage(), bindings: [
      CartBinding(),
      ProductsBinding(),
    ]),
    GetPage(
        name: Routes.CART,
        page: () => CartPage(/* Get.arguments */),
        bindings: [CartBinding(), CartProductBinding()]),
    GetPage(
        name: Routes.PRODUCT,
        page: () => ProductPage(Get.arguments),
        bindings: [
          ProductBinding(),
          CartBinding(),
        ]),
    GetPage(
        name: Routes.EDIT,
        page: () => EditProductPage(Get.arguments),
        bindings: [
          ProductBinding(),
          CartBinding(),
        ]),
  ];
}
