import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/data/model/cart_product_model.dart';
import 'package:lojabike/app/routes/app_routes.dart';

import 'custom_icon_button.dart';

class CartTile extends StatefulWidget {
  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final box = GetStorage('login_firebase');

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool at = box.read('at') ?? false;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(widget.cartProduct.product.images!.first),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.cartProduct.product.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Tamanho: ${widget.cartProduct.size}',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    widget.cartProduct.hasStock
                        ? Text(
                            'R\$ ${widget.cartProduct.unitPricea.toStringAsFixed(2)}\nR\$ ${widget.cartProduct.unitPricev.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Sem Estoque!',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          )
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                CustomIconButton(
                  iconData: Icons.add,
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    setState(() {
                      widget.cartProduct.increment();
                    });
                  },
                ),
                Text(
                  '${widget.cartProduct.quantity}',
                  // '${_.quantity}',
                  style: const TextStyle(fontSize: 20),
                ),
                CustomIconButton(
                  iconData: Icons.remove,
                  color: widget.cartProduct.quantity! > 1
                      ? Theme.of(context).primaryColor
                      : Colors.red,
                  onTap: () {
                    widget.cartProduct.decrement();
                    setState(() {
                      if (widget.cartProduct.quantity! <= 0)
                        setState(() {
                          Get.toNamed(Routes.PRODUCTS);
                        });
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
