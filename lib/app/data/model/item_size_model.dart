class ItemSize {
  ItemSize(
      {required this.name,
      required this.pricea,
      required this.pricev,
      required this.stock});

  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'].toString();
    pricea = num.parse(map['pricea'].toString());
    pricev = num.parse(map['pricev'].toString());
    stock = int.parse(map['stock'].toString());
  }

  late String name;
  late num pricea;
  late num pricev;
  late int stock;

  bool get hasStock => stock > 0;

  ItemSize clone() {
    return ItemSize(
      name: name,
      pricea: pricea,
      pricev: pricev,
      stock: stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pricea': pricea,
      'pricev': pricev,
      'stock': stock,
    };
  }

/*   @override
  String toString() {
    return 'ItemSize{name: $name, pricea: $pricea, pricev: $pricev, stock: $stock}';
  } */
}
