import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/data/model/item_size_model.dart';
import 'package:lojabike/app/data/model/product_model.dart';

class SizeWidget extends StatefulWidget {
  const SizeWidget({required this.size});

  final ItemSize size;

  @override
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  @override
  Widget build(BuildContext context) {
    print('cart tile select ${widget.size.name}');
    //final ctrlprod = Get.find<Product>();
    final selected = widget.size == Get.find<Product>().getSelectedSize();
    print(selected.toString());

    Color color;
    if (!widget.size.hasStock)
      color = Colors.red.withAlpha(50);
    else if (selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GetBuilder<Product>(
      id: 'size',
      init: Product(),
      builder: (_) {
        return GestureDetector(
          onTap: () {
            if (widget.size.hasStock) {
              _.setSelectedSize(widget.size);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: color,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    widget.size.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Atacado.: R\$ ${widget.size.pricea.toStringAsFixed(2)} \nVareijo.: R\$ ${widget.size.pricev.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
