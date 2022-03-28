import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/product_controller.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';
import 'package:lojabike/app/routes/app_routes.dart';

import 'components/product_list_tile.dart';
import 'components/search_dialog.dart';
import 'drawer_page.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final entryProvider = EntryProvider();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      //id: "products",
      init: ProductController(),
      initState: (state) {
        // ignore: unused_local_variable
        final filterProducts = Get.find<ProductController>().filteredProducts;
        Get.find<ProductController>().onReady();
      },
      builder: (_) {
        final filterProducts = _.filteredProducts;
        return Scaffold(
          backgroundColor: Colors.transparent,
          drawer: DrawerPage(),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Produtos"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context, builder: (_) => SearchDialog());
                  if (search != null) {
                    _.search = search;
                    setState(() {});
                  }
                },
              ),
              //varificar se é admin
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Get.toNamed(Routes.EDIT,
                      arguments: Product(
                          id: '',
                          description: '',
                          marca: '',
                          name: '',
                          pCompra: '0',
                          qtdmin: '0',
                          deleted: false,
                          images: [],
                          sizes: []));
                },
              ),
            ],
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: filterProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filterProducts[index]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Get.toNamed(Routes.CART);
            },
            child: Icon(Icons.shopping_cart),
          ),
        );
      },
    );
  }
}
