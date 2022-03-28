import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/data/model/cart_product_model.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';

class CartManager extends GetxController {
  GetStorage box = GetStorage('login_firebase');
  final provider = EntryProvider();
  List<CartProduct> items = [];
  num productsPrice = 0.0;
  num productsPricev = 0.0;

  @override
  void onInit() {
    _loadCartItems();
    super.onInit();
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await provider.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)
          ..addListener(() {
            _onItemUpdated();
          }))
        .toList();
    update();
    //box.write('items', items);
  }

  void addToCart(Product product) async {
    //tenta incrementar se ja existe e tem estoque,
    //senão add um novo produto na tela de carrinho.
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(() {
        _onItemUpdated();
      });
      items.add(cartProduct);
      //box.write('items', items);
      await provider.cartReference.add(cartProduct.toCartItemMap()).then((doc) {
        cartProduct.id = doc.id;
      });
      _onItemUpdated();
    }
    update();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    provider.cartReference.doc(cartProduct.id).delete();
    //box.write('items', items);
    cartProduct.removeListener(() {
      update();
      // _onItemUpdated();
    });
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    productsPricev = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;
      box.write('productsPrice', productsPrice);
      productsPricev += cartProduct.totalPricev;
      box.write('productsPricev', productsPricev);
      //update();
      _updateCartProduct(cartProduct);
    }
    update();
    //print(productsPrice);
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.quantity! > 0) {
      provider.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
      update();
    }
  }

  bool get isCartValid {
    bool tem = false;
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) {
        return tem;
      } else {
        tem = true;
      }
    }
    return tem;
  }
}
