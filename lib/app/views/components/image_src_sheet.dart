import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected});

  final Function(File) onImageSelected;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              await Permission.photos.request();
              await Permission.storage.request();

              try {
                var permissionStatus = await Permission.photos.status;
                if (permissionStatus.isGranted) {
                  final file =
                      await picker.pickImage(source: ImageSource.camera);
                  if (file != null) {
                    final fi = File(file.path);
                    onImageSelected(fi);
                  } else {
                    print('Imagem não localizada!');
                  }
                }
              } on PlatformException catch (e) {
                print(e.code);
              }
            },
            child: const Text('Câmera'),
          ),
          TextButton(
            onPressed: () async {
              await Permission.photos.request();
              await Permission.storage.request();

              try {
                var permissionStatus = await Permission.photos.status;
                if (permissionStatus.isGranted) {
                  final file =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    final fi = File(file.path);
                    onImageSelected(fi);
                  } else {
                    print('Imagem não localizada!');
                  }
                }
              } on PlatformException catch (e) {
                print(e.code);
              }
            },
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
