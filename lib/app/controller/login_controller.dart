import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lojabike/app/data/model/user_model.dart';
import 'package:lojabike/app/data/repository/login_repository.dart';
import 'package:lojabike/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginRepository repository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  GetStorage box = GetStorage('login_firebase');

  @override
  void onReady() {
    isLogged();
    super.onReady();
  }

  void isLogged() {
    if (box.hasData("auth")) {
      UserModel user = UserModel(
        id: box.read("auth")["id"],
        email: box.read("auth")["email"],
        name: box.read("auth")["name"],
        urlimage: box.read("auth")["urlimage"],
      );
      print(user);

      Get.offAllNamed(Routes.HOMEPAGE, arguments: user);
    }
  }

  void register() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    UserModel? user = await repository.createUserWithEmailAndPasswor(
        emailTextController.text,
        passwordTextController.text,
        nameTextController.text);
    // ignore: unnecessary_null_comparison
    if (user != null) {
      box.write("auth", user);
      Get.offAllNamed(Routes.HOMEPAGE, arguments: user);
    }
  }

  void login() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    UserModel? user = await repository.signInWithEmailAndPassword(
        emailTextController.text, passwordTextController.text);

    // ignore: unnecessary_null_comparison
    if (user != null) {
      box.write("auth", user);
      Get.offAllNamed(Routes.HOMEPAGE, arguments: user);
    }
  }

  void logout() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    repository.signOut();
    Get.offAllNamed(Routes.INITIAL);
  }
}
