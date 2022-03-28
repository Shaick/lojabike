import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/cart_controller.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/routes/app_routes.dart';

import 'components/size_widget.dart';

class ProductPage extends StatelessWidget {
  ProductPage(this.product);

  final Product product;
  final cartctrl = Get.put(CartManager());
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GetBuilder<Product>(
      id: "product",
      init: Product(),
      // ignore: missing_return
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(product.name!),
            centerTitle: true,
            actions: [
              //varificar se é admin
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.toNamed(Routes.EDIT, arguments: product);
                  }),
            ],
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: product.images!.map((url) {
                    return Image.network(url);
                  }).toList(),
                  dotSize: 4,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: primaryColor,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Em estoque:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      _.getSelectedSize().name.contains('Selecione')
                          ? "0"
                          : _.getSelectedSize().stock.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        //fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          product.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            'Tamanhos',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes!.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    product.hasStock
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity - 20,
                              height: 44,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black)),
                                onPressed: _.getSelectedSize() ==
                                        product
                                            .findSize(_.getSelectedSize().name)
                                    ? () {
                                        cartctrl.addToCart(product);
                                        Get.toNamed(Routes.CART,
                                            arguments: 'vareijo');
                                      }
                                    : null,
                                child: Text(
                                  "add ao Carinho",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
