import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/product_controller.dart';
import 'package:lojabike/app/data/model/product_model.dart';

import 'components/images_form.dart';
import 'sizes_form.dart';

class EditProductPage extends StatelessWidget {
  EditProductPage(Product p)
      : editing = p.id!.isNotEmpty,
        product = p.id!.isNotEmpty ? p.clone() : Product(sizes: []);

  final Product product;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final prodctrl = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
/*     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)); */

    return GetBuilder<Product>(
      init: Product(sizes: []),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                ImagesForm(product),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        initialValue: product.name,
                        decoration: const InputDecoration(
                          hintText: 'Título',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        validator: (name) {
                          if (name!.length < 6) return 'Título muito curto';
                          return null;
                        },
                        onSaved: (name) => product.name = name!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.description,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: 'Descrição', border: InputBorder.none),
                        maxLines: null,
                        validator: (desc) {
                          if (desc!.length < 3) return 'Descrição muito curta';
                          return null;
                        },
                        onSaved: (desc) => product.description = desc!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Marca',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.marca,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: 'Marca', border: InputBorder.none),
                        validator: (desc) {
                          if (desc!.length < 3) return 'Nome Marca muito curto';
                          return null;
                        },
                        onSaved: (marca) => product.marca = marca!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Preço de Custo',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.pCompra,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: 'R\$', border: InputBorder.none),
                        validator: (desc) {
                          if (desc!.length < 3) return 'Descrição muito curta';
                          return null;
                        },
                        onSaved: (pCompra) => product.pCompra = pCompra!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'Quantidade Minima',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        initialValue: product.qtdmin,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                            hintText: '50', border: InputBorder.none),
                        validator: (desc) {
                          if (desc!.length < 3) return 'Descrição muito curta';
                          return null;
                        },
                        onSaved: (qtdmin) => product.qtdmin = qtdmin!,
                      ),
                      SizesForm(product),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(color: Colors.white),
                              onSurface: Theme.of(context)
                                  .primaryColor
                                  .withAlpha(100)),
                          onPressed: !product.loading
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    CircularProgressIndicator();
                                    formKey.currentState!.save();

                                    await product.save();
                                    prodctrl.updatee(product);
                                    Navigator.of(context).pop();
                                  }
                                }
                              : null,
                          child: product.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.black),
                                )
                              : const Text(
                                  'Salvar',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
