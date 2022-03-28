import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:lojabike/app/data/model/fornecedor_model.dart';
import 'package:lojabike/app/routes/app_routes.dart';

class EntryProvider {
  final _storage = FirebaseStorage.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get user => _firebaseAuth.currentUser;

  DocumentReference get order => _db.collection('aux').doc('ordercounter');

  CollectionReference get refor => _db.collection('Fornecedores');
  CollectionReference get refprod => _db.collection('Produtos');
  CollectionReference get refvend => _db.collection('Vendedor');
  CollectionReference get cartReference =>
      _db.collection('Vendedor').doc(user!.uid).collection('cart');

  DatabaseReference get fornecedoresRef =>
      FirebaseDatabase.instance.reference().child("Loja").child("Fornecedores");

  Future<String> uploadPerfil(file) async {
    var snapshot =
        await _storage.ref().child('${user!.uid}/PERFIL').putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadFornecedor(file, uid) async {
    var snapshot =
        await _storage.ref().child('Fornecedores').child(uid).putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getFornecedores() async {
    var map;
    await fornecedoresRef.once().then((dataSnap) {
      map = dataSnap.value;
    });
    return map;
  }

  Future setFornecedoress(String uid, Fornecedor fornece) async {
    await refor.doc(uid).set(fornece.toMap()).then((value) {
      Get.toNamed(Routes.HOMEPAGE);
    });
  }

  Future setFornecedores(String uid, Fornecedor fornece) async {
    await fornecedoresRef.child(uid).set(fornece.toMap()).then((value) {
      Get.toNamed(Routes.HOMEPAGE);
    });
  }
}
