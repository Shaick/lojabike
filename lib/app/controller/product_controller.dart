import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';

class ProductController extends GetxController {
  ProductController() {
    _loadAllProducts();
  }
  final entryProvider = EntryProvider();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late List<Product> allProducts = [];
  late List<DocumentSnapshot> pro;

  String _search = '';
  String? id;

  String get search => _search;

  set search(String value) {
    _search = value;
    update();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where(
          (prod) => prod.name!.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future _loadAllProducts() async {
    await entryProvider.refprod.get().then((value) {
      pro = value.docs.toList();
      int i = 0;
      for (DocumentSnapshot docc in pro) {
        id = docc.id;
        Map<String, dynamic> map = docc.data() as Map<String, dynamic>;
        map.addAll({'id': id!});
        Product duct = Product.fromMap(map);

        allProducts.add(duct);
        //allProducts.elementAt(i).id = docc.id;
        update();
        i++;
      }
      i = i;
      return allProducts;
    });
  }

  Product? findProductByMark(String marca) {
    try {
      return allProducts.firstWhere((p) => p.marca == marca);
    } catch (e) {
      return null;
    }
  }

  void updatee(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    update();
  }

/*   Future editProduct(Product product) async {
    //entryProvider.refprod.doc(product.id).update(product.toMap());
  } */
}
