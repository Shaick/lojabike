import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/data/model/user_model.dart';

class LoginProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage('login_firebase');

  User? get user => _firebaseAuth.currentUser;

  Stream<UserModel?> get onAuthStateChanged => _firebaseAuth
      .userChanges()
      .map((User? currentUser) => UserModel.fromSnapshot(currentUser!));

  Future<void> setUserUrlPhoto(String photoUrl) async {
    await user!.updatePhotoURL(
        'https://aux.iconspalace.com/uploads/guest-icon-256.png');

    await user!.reload();
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      // atualizar nome do User
      await currentUser!.updateDisplayName(name);
      await currentUser.updatePhotoURL(
          'https://aux.iconspalace.com/uploads/guest-icon-256.png');

      await currentUser.reload();

      return UserModel.fromSnapshot(currentUser);
    } on FirebaseAuthException catch (e) {
      Get.back();
      print(e);
      switch (e.code) {
        case 'email-already-in-use':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Email já cadastrado."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'wrong-password':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Senha não confere."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'user-disable':
          Get.defaultDialog(
              title: "ERROR", content: Text("Usuário desativado."));
          break;
        case 'too-many-requests':
          Get.defaultDialog(
            title: "ERROR",
            content:
                Text("Muitas tentativas, dados incorretos, tente mais tarde."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'operation-not-allowed':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Login não autorizado."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        default:
          Get.defaultDialog(
            title: "ERROR",
            content: Text("${e.toString()}"),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
      }
      return null;
    }
  }

  // ignore: missing_return
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return UserModel.fromSnapshot(currentUser!);
    } on FirebaseAuthException catch (e) {
      Get.back();
      print(e);
      switch (e.code) {
        case 'wrong-password':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Senha não confere."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'user-disable':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Usuário desativado."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'user-not-found':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Usuário não encontrado."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'too-many-requests':
          Get.defaultDialog(
            title: "ERROR",
            content:
                Text("Muitas tentativas, dados incorretos, tente mais tarde."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
        case 'operation-not-allowed':
          Get.defaultDialog(
            title: "ERROR",
            content: Text("Login não autorizado."),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );

          break;
        default:
          Get.defaultDialog(
            title: "ERROR",
            content: Text("${e.toString()}"),
            cancel: Icon(
              Icons.warning,
              color: Colors.amber,
              size: 40,
            ),
          );
          break;
      }
      return null;
    }
  }

  //Logoff
  singOut() {
    box.write("auth", null);
    //box.erase();
    return _firebaseAuth.signOut();
  }
}
