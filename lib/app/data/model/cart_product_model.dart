import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'item_size_model.dart';

class CartProduct extends GetxController {
  String? id;
  String? productId;
  int? quantity;
  String? size;
  Product? _product;
  num? fixedPrice;

  CartProduct({
    this.id,
    this.productId,
    this.size,
    this.quantity,
  });

  GetStorage box = GetStorage('login_firebase');
  final _db = FirebaseFirestore.instance;
  CartProduct.fromProduct(this._product) {
    productId = product.id!;
    quantity = 1;
    //size = box.read('name');
    //product.selectedSize.name; // box.read('name'); //
    size = product.getSelectedSize().name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.id;
    productId = document.get('pid') as String; //.data()['pid'] as String;
    quantity = document.get('quantity') as int; //.data()['quantity'] as int;
    size = document.get('pid') as String; //.data(). ['size'] as String;

    var map;

    getProduct() async {
      await _db.collection('Produtos').doc(productId).get().then((dataSnap) {
        map = dataSnap.data();
        _product = Product.fromMap(map);
        update();
      });
    }

    getProduct();
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    _db.doc('Produtos/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  Product get product => _product!;
  set product(Product value) {
    _product = value;
    update();
  }

  ItemSize? get itemSize {
    return product.findSize(size!);
  }

  num get unitPricea {
    return itemSize?.pricea ?? 0;
  }

  num get unitPricev {
    return itemSize?.pricev ?? 0;
  }

  num get totalPrice => unitPricea * quantity!;

  num get totalPricev => unitPricev * quantity!;

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.getSelectedSize().name == size;
  }

  void increment() {
    quantity = quantity! + 1;
    update();
  }

  void decrement() {
    quantity = quantity! - 1;
    update();
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity!;
  }
}
