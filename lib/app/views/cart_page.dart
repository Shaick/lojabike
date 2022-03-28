import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/cart_controller.dart';
import 'package:lojabike/app/routes/app_routes.dart';
import 'components/cart_tile.dart';
import 'components/price_card.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

bool at = false;
GetStorage box = GetStorage('login_firebase');

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartManager>(
      id: "cart",
      init: CartManager(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Venda Atual'),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Column(
                children: _.items
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              Switch(
                value: at,
                onChanged: (bool tem) {
                  setState(() {
                    at = tem;
                    box.write('at', tem);
                  });
                },
              ),
              PriceCard(
                buttonText: "Continuar",
                onPressed: () {
                  Get.toNamed(Routes.CHECKOUT);
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Get.toNamed(Routes.PRODUCTS);
            },
            child: Icon(Icons.add_shopping_cart),
          ),
        );
      },
    );
  }
}
