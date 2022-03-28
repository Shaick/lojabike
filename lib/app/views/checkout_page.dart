import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/checkout_manager.dart';
import 'package:lojabike/app/routes/app_routes.dart';

import 'components/price_card.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
        centerTitle: true,
      ),
      body: GetBuilder<CheckoutManager>(
        init: CheckoutManager(),
        builder: (_) {
          if (_.loading) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                  ),
                  Text(
                    "Processando seu pagamento...",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView(
            children: [
              PriceCard(
                buttonText: 'Finalizar Venda',
                onPressed: () {
                  _.checkout(onStockFail: (e) {
                    Get.snackbar(
                      "Erro",
                      '${e.toString()}',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.redAccent,
                      snackbarStatus: (status) {
                        if (status == SnackbarStatus.CLOSED) {
                          Get.offAndToNamed('/cart');
                        }
                      },
                    );
                  }, onSucess: () {
                    Get.offNamedUntil(Routes.ORDER, (route) => true);
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
