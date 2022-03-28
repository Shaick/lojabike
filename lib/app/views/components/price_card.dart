import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/controller/cart_controller.dart';

class PriceCard extends StatelessWidget {
  PriceCard({required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;
  final box = GetStorage('login_firebase');

  @override
  Widget build(BuildContext context) {
    final bool at = box.read('at') ?? false;
    return GetBuilder<CartManager>(
      init: CartManager(),
      builder: (_) {
        final productsPrice = _.productsPrice;
        final productsPricev = _.productsPricev;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Resumo do Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Subtotal'),
                    at
                        ? Text('R\$ ${productsPrice.toStringAsFixed(2)}')
                        : Text('R\$ ${productsPricev.toStringAsFixed(2)}')
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    at
                        ? Text(
                            'R\$ ${productsPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          )
                        : Text('R\$ ${productsPricev.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  /*  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                  textColor: Colors.white, */
                  onPressed: _.isCartValid ? onPressed : null,
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
