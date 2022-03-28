import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getwidget/getwidget.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:lojabike/app/controller/fcontroller.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';
import 'package:lojabike/app/utils/uf.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:permission_handler/permission_handler.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:uuid/uuid.dart';

class CarFornecedor extends StatelessWidget {
  //GetStorage box = GetStorage('login_firebase');
  //final fController = Get.put(FController());

  final entryProvider = EntryProvider();
  final _formKey = GlobalKey<FormState>();
  final imageUrl = ''.obs;
  final uff = 'UF'.obs;
  final uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    String photo =
        "https://firebasestorage.googleapis.com/v0/b/bikearcoiris.appspot.com/o/Fornecedores%2Ffornecedor.jpg?alt=media&token=12ac6439-8d35-4f68-b8e5-297db7b3b3f6";

    String uid = uuid.v1();
    void uploadImage() async {
      final _picker = ImagePicker();
      final EntryProvider entryProvider = EntryProvider();

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
          // ignore: unnecessary_null_comparison
          if (_image != null) {
            //upload firebase

            imageUrl.value = await entryProvider.uploadFornecedor(file, uid);
            photo = imageUrl.value;
            entryProvider.fornecedoresRef
                .child(uid)
                .child("photoUrl")
                .set(imageUrl.value);
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

    return GetBuilder<FController>(
      init: FController(),
      builder: (_) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Cadastro de Fornecedor"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => (imageUrl.value != '')
                            ? GestureDetector(
                                onTap: () {
                                  uploadImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GFAvatar(
                                    shape: GFAvatarShape.standard,
                                    backgroundColor: Colors.grey[500],
                                    backgroundImage:
                                        NetworkImage(imageUrl.obs.toString()),
                                    radius: 48,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  uploadImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, right: 8),
                                  child: GFAvatar(
                                    shape: GFAvatarShape.standard,
                                    backgroundColor: Colors.grey[500],
                                    backgroundImage: NetworkImage(photo),
                                    radius: 48,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 0),
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 130,
                          child: TextFormField(
                            onChanged: (value) {
                              _.changePhone = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Telefone",
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 0, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'Nome da Empresa!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.addressBook),
                                hintText: 'Nome da Empresa',
                              ),
                              onChanged: (String value) => _.changeName = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 10) {
                                  return 'Inscrição Estadual!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.solidIdCard),
                                hintText: 'Inscrição Estadual!',
                              ),
                              onChanged: (String value) => _.changeIe = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 10) {
                                  return 'CNPJ!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.solidIdCard),
                                hintText: 'CNPJ!',
                              ),
                              onChanged: (String value) => _.changeCnpj = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (!value!.isEmail) {
                                  return 'Entre com um E-mail válido!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.at),
                                hintText: 'Email',
                              ),
                              onChanged: (String value) =>
                                  _.changeEmail = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (!value!.isURL) {
                                  return 'Entre com um Site válido!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.code),
                                hintText: 'Site',
                              ),
                              onChanged: (String value) => _.changeSite = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Cep!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.mailBulk),
                                hintText: 'Cep',
                              ),
                              onChanged: (String value) => _.changeCep = value,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 8, right: 50, bottom: 8),
                        child: SizedBox(
                          width: 70,
                          height: 40,
                          child: DropdownButton(
                            icon: Icon(FontAwesomeIcons.flag),
                            hint: Obx(
                              () => Text(uff.obs.toString()),
                            ),
                            items: uf.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _.changeUf = value.toString();
                              uff.value = value as String;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'Cidade!';
                                }
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.city),
                                hintText: 'Cidade',
                              ),
                              onChanged: (String value) => _.changeCity = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'Bairro!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.mapMarkedAlt),
                                hintText: 'Bairro',
                              ),
                              onChanged: (String value) =>
                                  _.changeDistrict = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value!.length < 3) {
                                  return 'Endereço!';
                                }
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt),
                                hintText: 'Endereço',
                              ),
                              onChanged: (String value) =>
                                  _.changeAddress = value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            text: "Cadastrar",
                            color: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            size: GFSize.LARGE,
                            fullWidthButton: true,
                            type: GFButtonType.solid,
                            onPressed: () {
                              _.changePhotoUrl =
                                  imageUrl.value != '' ? imageUrl.value : photo;
                              if (_formKey.currentState!.validate()) {
                                if (uff.value == 'UF') {
                                  Get.defaultDialog(
                                    title: "UF",
                                    content: Text('Selecione um Estado'),
                                    cancel: Icon(
                                      Icons.input,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  );
                                  return;
                                }
                                entryProvider.getFornecedores();
                                _.saveEntry(uid);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
