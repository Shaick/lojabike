import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lojabike/app/controller/fcontroller.dart';
import 'package:lojabike/app/controller/login_controller.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';
import 'package:lojabike/app/data/provider/login_provider.dart';
import 'package:lojabike/app/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final fController = Get.find<FController>();
    final imageUrl = ''.obs;
    LoginProvider user = LoginProvider();
    //GetStorage box = GetStorage('login_firebase');
    String? name = user.user!.displayName;
    String? email = user.user!.email;
    String? photo = user.user!.photoURL;

    uploadImage() async {
      final _picker = ImagePicker();
      final EntryProvider entryProvider = EntryProvider();
      final LoginProvider loginProvider = LoginProvider();
      XFile? _image;
      //File _storageImage;

      //Check Permissions
      await Permission.photos.request();

      try {
        var permissionStatus = await Permission.photos.status;

        if (permissionStatus.isGranted) {
          //Select Image
          _image = await _picker.pickImage(source: ImageSource.gallery);
          var file = File(_image!.path);

          if (file.path != '') {
            //upload firebase

            imageUrl.value = await entryProvider.uploadPerfil(file);
            photo = imageUrl.value;
            loginProvider.setUserUrlPhoto(imageUrl.value);
          } else {
            print('Imagem não localizada!');
          }
        } else {
          print('Conceda permissão para acessar galeria!');
          Get.defaultDialog(
            title: "Galeria",
            content: Text('Conceda permissão para acessar galeria!'),
            cancel: Icon(
              Icons.camera,
              color: Colors.blueGrey,
              size: 40,
            ),
          );
          await Permission.photos.request();
        }
      } on PlatformException catch (e) {
        print(e.code);
      }
    }

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => (imageUrl.value != '')
                        ? GestureDetector(
                            onTap: () {
                              uploadImage();
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(user.user!.photoURL!),
                            ))
                        : GestureDetector(
                            onTap: () {
                              uploadImage();
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(photo!),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$name | $email',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.HOMEPAGE);
              },
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text("Inicio"),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.FORNECEDORES);
              },
              leading: Icon(
                Icons.inbox,
                color: Colors.black,
              ),
              title: Text("Fornecedores"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.PRODUCTS);
              },
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("Produtos e Serviços"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed("/order");
              },
              leading: Icon(
                Icons.payment,
                color: Colors.black,
              ),
              title: Text("Caixa"),
            ),
            ListTile(
              onTap: () {
                LoginController().logout();
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text("Sair"),
            ),
          ],
        ),
      ),
    );
  }
}
