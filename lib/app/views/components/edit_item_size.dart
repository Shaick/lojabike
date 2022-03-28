import 'package:flutter/material.dart';
import 'package:lojabike/app/data/model/item_size_model.dart';

import 'custom_icon_button.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize(
      {Key? key,
      required this.size,
      required this.onRemove,
      required this.onMoveUp,
      required this.onMoveDown})
      : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 12,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name!.isEmpty) return 'Inválido';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 16,
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if (int.tryParse(stock!) == null) return 'Inválido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock)!,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 15,
          child: TextFormField(
            initialValue: size.pricea.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: 'Preço-A', isDense: true, prefixText: 'R\$'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price!) == null) return 'Inválido';
              return null;
            },
            onChanged: (price) => size.pricea = num.tryParse(price)!,
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          flex: 15,
          child: TextFormField(
            initialValue: size.pricev.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: 'Preço-V', isDense: true, prefixText: 'R\$'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price!) == null) return 'Inválido';
              return null;
            },
            onChanged: (price) => size.pricev = num.tryParse(price)!,
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}
