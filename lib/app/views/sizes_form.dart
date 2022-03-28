import 'package:flutter/material.dart';
import 'package:lojabike/app/data/model/item_size_model.dart';
import 'package:lojabike/app/data/model/product_model.dart';
import 'components/custom_icon_button.dart';
import 'components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    List<ItemSize> sizex;
    if (product.sizes != null) {
      print(product.sizes);
      sizex = product.sizes!;
    } else {
      sizex = [];
    }
    return FormField<List<ItemSize>>(
      initialValue: sizex,
      validator: (sizes) {
        if (sizes!.isEmpty) return 'Insira um tamanho';
        return null;
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    sizex.add(
                        ItemSize(name: '', pricea: 0, pricev: 0, stock: 0));
                    state.didChange(sizex);
                  },
                )
              ],
            ),
            Column(
                children: sizex.isNotEmpty
                    ? sizex.map((size) {
                        return EditItemSize(
                          key: ObjectKey(size),
                          size: size,
                          onRemove: () {
                            sizex.remove(size);
                            state.didChange(sizex);
                          },
                          onMoveUp: size != sizex.first
                              ? () {
                                  final index = sizex.indexOf(size);
                                  sizex.remove(size);
                                  sizex.insert(index - 1, size);
                                  state.didChange(sizex);
                                }
                              : () {},
                          onMoveDown: size != sizex.last
                              ? () {
                                  final index = sizex.indexOf(size);
                                  sizex.remove(size);
                                  sizex.insert(index + 1, size);
                                  state.didChange(state.value);
                                }
                              : () {},
                        );
                      }).toList()
                    : [Container()]),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
