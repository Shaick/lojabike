import 'dart:io';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:lojabike/app/data/model/product_model.dart';

import 'image_src_sheet.dart';

class ImagesForm extends StatelessWidget {
  ImagesForm(this.product);

  final Product product;
  final prodctrl = Get.put(Product(sizes: []));

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images!),
      validator: (images) {
        if (images!.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          //prodctrl.newImagee = file;
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value!.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (image is String)
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.file(
                          image as File,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.red,
                          onPressed: () {
                            state.value!.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
                  ..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ));
                      },
                    ),
                  )),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: GFToast(
                  text: state.errorText,
                  animationDuration: Duration(seconds: 5),
                  backgroundColor: Colors.redAccent,
                  alignment: Alignment.bottomCenter,
                ),
              ),
          ],
        );
      },
    );
  }
}
