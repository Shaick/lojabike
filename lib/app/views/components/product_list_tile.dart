import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/routes/app_routes.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String img =
        'https://th.bing.com/th/id/Raf6e7bf06bda5ba92aedf0e7c7cbe494?rik=OT3%2fhRVnbrBGtw&riu=http%3a%2f%2fwww.triarteindustria.com.br%2fwp-content%2fuploads%2f2014%2f05%2fimagem_indisponivel.jpg&ehk=LgSJncqdd8wiUXRAZ7aTxaaapiNsM4wPDuPglOIofhc%3d&risl=&pid=ImgRaw';
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PRODUCT, arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images!.first),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Em estoque',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '${product.totalStock}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
