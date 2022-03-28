import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';

import 'cart_product_model.dart';

class Order {
  //final uid = Uuid();
  final provider = EntryProvider();
  GetStorage box = GetStorage('login_firebase');
  List<CartProduct> items = [];

  Order.fromCartManager() {
    items = box.read('items'); //List.from(cartManager.items);
    price = box.read('productsPrice'); //cartManager.productsPrice;
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> save() async {
    _db.collection('orders').doc(orderId).set({
      'id': orderId,
      'seller': provider.user!.displayName,
      'date': formatDate(
          DateTime.now(), [d, '/', mm, '/', yyyy, ' às ', hh, ':', mm]),
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
    });
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.id;

    items = (doc.get('items') as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.get('price') as num;
    date = doc.get('date') as String;
  }

  String? orderId;

  late num price;

  late String date;

  String get formattedId => '#${orderId!.padLeft(6, '0')}';

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, date: $date}';
  }
}
