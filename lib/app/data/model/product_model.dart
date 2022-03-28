import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import 'item_size_model.dart';

class Product extends GetxController {
  late String? id;
  late String? name;
  late String? description;
  late String? marca;
  late String? pCompra;
  late String? qtdmin;
  late bool deleted;
  late List<String>? images = [];
  List<ItemSize>? sizes = [];
  List<dynamic>? newImages = [];

  ItemSize? _selectedSize;

  GetStorage box = GetStorage('login_firebase');
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('Produtos/$id');
  Reference get storageRef => storage.ref().child('Produtos').child(id!);

  void setSelectedSize(ItemSize itemSize) {
    _selectedSize = itemSize;
    update(['size', 'product', 'cart', 'carttile'], true);
    Map<String, dynamic> itemSizeMap = itemSize.toMap();
    box.write('select', itemSizeMap);
  }

  set newImagee(File neww) {
    newImages!.add.call(neww);
    // newImages.add(neww);
    update();
  }

  ItemSize itz = ItemSize.fromMap(<String, dynamic>{
    'name': 'Selecione',
    'pricea': 0,
    'pricev': 0,
    'stock': 0
  });

  ItemSize getSelectedSize() {
    if (_selectedSize == null && box.read('select') == null) {
      return itz;
    } else if (_selectedSize != null) {
      itz = _selectedSize!;
    } else if (box.read('select') != null) {
      itz = ItemSize.fromMap(box.read('select'));
    }
    return itz;
  }

  Product(
      {this.id,
      this.name,
      this.marca,
      this.pCompra,
      this.qtdmin,
      this.description,
      this.images,
      this.sizes,
      this.deleted = false}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromMap(Map document) {
    sizes = [];
    id = document['id'];
    name = document['nome'] as String;
    description = document['description'] as String;
    marca = document['marca'] as String;
    pCompra = document['p_compra'] as String;
    qtdmin = document['qtd_min'] as String;
    images = List<String>.from(document['imagens'] as List<dynamic>);
    deleted = (document['deleted'] ?? false) as bool;
    var doc = document['sizes'] as List<dynamic>;
    sizes = List<ItemSize>.from(doc.map((size) => ItemSize.fromMap(size)));
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['nome'] as String;
    description = document['description'] as String;
    marca = document['marca'] as String;
    pCompra = document['p_compra'] as String;
    qtdmin = document['qtd_min'] as String;
    images = List<String>.from(document['imagens'] as List<dynamic>);
    sizes = (document['sizes'] as List<dynamic>)
        .map((size) => ItemSize.fromMap(size as Map<String, dynamic>))
        .toList();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    update();
  }

  int get totalStock {
    int sttock = 0;
    for (final size in sizes!) {
      sttock += size.stock;
    }
    return sttock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted;
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes!.map((size) => size.toMap()).toList();
  }

  ItemSize? findSize(String name) {
    try {
      return sizes!.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      marca: marca,
      pCompra: pCompra,
      qtdmin: qtdmin,
      description: description,
      images: List.from(images!),
      sizes: sizes!.map((size) => size.clone()).toList(),
      deleted: deleted,
    );
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'nome': name,
      'description': description,
      'marca': marca,
      'p_compra': pCompra,
      'qtd_min': qtdmin,
      'sizes': exportSizeList(),
      'deleted': deleted
    };

    if (id == null) {
      final doc = await firestore.collection('Produtos').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];

    for (final newImage in newImages!) {
      if (images!.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = task.snapshot;
        String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for (final image in images!) {
      if (!newImages!.contains(image) && image.contains('firebase')) {
        try {
          final ref = storage.refFromURL(image);
          await ref.delete();
        } catch (e) {
          print('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.update({'imagens': updateImages});

    images = updateImages;

    loading = false;
  }

  void delete() {
    firestoreRef.update({'deleted': true});
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
