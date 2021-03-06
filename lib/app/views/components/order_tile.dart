import 'package:flutter/material.dart';
import 'package:lojabike/app/data/model/order_model.dart';

import 'order_products_tile.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              'Produtos vendidos',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          )
        ],
      ),
    );
  }
}
