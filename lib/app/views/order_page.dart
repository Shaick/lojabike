import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/order_controller.dart';

import 'components/empty_card.dart';
import 'components/order_tile.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 250, 150),
      appBar: AppBar(
        title: Text('Minhas Vendas'),
        centerTitle: true,
      ),
      body: GetBuilder<OrdersManager>(
        init: OrdersManager(),
        builder: (_) {
          if (_.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhuma venda encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: _.orders.length,
            itemBuilder: (context, index) {
              return OrderTile(_.orders[index]);
            },
          );
        },
      ),
    );
  }
}
