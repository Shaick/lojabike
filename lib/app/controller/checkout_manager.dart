import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/controller/cart_controller.dart';
import 'package:lojabike/app/data/model/cart_product_model.dart';
import 'package:lojabike/app/data/model/order_model.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';

class CheckoutManager extends GetxController {
  CartManager? cartManager;
  List<CartProduct> items = [];
  GetStorage box = GetStorage('login_firebase');
  final provider = EntryProvider();
  final _db = FirebaseFirestore.instance;

  bool loading = false;

  setLoading(bool load) {
    loading = load;
    update();
  }

  Future<void> checkout({Function? onStockFail, Function? onSucess}) async {
    loading = true;

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail!(e);
      loading = false;
      return;
    }

    //  Processar pagamento

    // ignore: unused_local_variable
    final orderId = await _getOrderId();

    final order = Order.fromCartManager();
    order.orderId = orderId.toString();

    await order.save();

    items = box.read('items');
    clear(items);
    loading = false;
    onSucess!();
    update();
  }

  void clear(itemss) {
    for (final carProduct in itemss) {
      provider.cartReference.doc(carProduct.id).delete();
      box.write('select', null);
      box.write('name', null);
      box.write('items', null);
      box.write('productsPrice', null);
      box.write('productsPricev', null);
    }
  }

  Future<int?> _getOrderId() async {
    try {
      final result = await _db.runTransaction((tx) async {
        final doc = await tx.get(provider.order);
        int orderId = doc.get('current') as int; // data()["current"];
        tx.update(provider.order, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'];
    } catch (e) {
      print(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock() async {
    items = box.read('items');
    print(items.length);
    // 1. Ler todos os estoques 3xM
    // 2. Decremento localmente os estoques 2xM
    // 3. Salvar os estoques no firebase 2xM
    return await _db.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithOutStock = [];
      for (final cartProduct in items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx
              .get(_db.collection('Produtos').doc(cartProduct.productId));
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;
        update();

        final size = product.findSize(cartProduct.size!);
        if (size!.stock - cartProduct.quantity! < 0) {
          // falha no estoque
          productsWithOutStock.add(product);
        } else {
          size.stock = size.stock - cartProduct.quantity!;
          productsToUpdate.add(product);
        }
      }

      if (productsWithOutStock.isNotEmpty) {
        var err;
        String names = " ";

        if (productsWithOutStock.length == 1) {
          names = productsWithOutStock.elementAt(0).name!;
          err = Future.error(
              '${productsWithOutStock.length} = $names sem estoque');
        } else {
          for (final prod in productsWithOutStock) {
            names += prod.name! + ", ";
          }
          err = Future.error(
              '${productsWithOutStock.length} = $names sem estoque');
        }
        return err;
      }

      for (final product in productsToUpdate) {
        tx.update(_db.collection('Produtos').doc(product.id),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
