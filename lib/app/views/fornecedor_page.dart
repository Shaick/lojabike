import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lojabike/app/controller/fcontroller.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';
import 'package:lojabike/app/routes/app_routes.dart';

class FornecedorPage extends StatefulWidget {
  final int index;
  FornecedorPage(this.index);
  @override
  _FornecedorPageState createState() => _FornecedorPageState();
}

class _FornecedorPageState extends State<FornecedorPage> {
  final fController = Get.find<FController>();
  final entryProvider = EntryProvider();
  String photoUrl = '';
  String name = '';
  String phone = '';
  String cnpj = '';
  String email = '';
  String id = '';

  remove() {
    print("remove");
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 150,
          child: GFAlert(
            type: GFAlertType.basic,
            width: 200,
            title: 'Excluir Fornecedor!',
            content: 'Deseja Excluir esse Fornecedor?',
            bottombar: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  child: GFButton(
                    size: GFSize.SMALL,
                    onPressed: () async {
                      await entryProvider.fornecedoresRef.child(id).remove();
                      Get.snackbar("Ok", "Fornecedor Excluido");
                      Get.toNamed(Routes.FORNECEDORES);
                    },
                    shape: GFButtonShape.pills,
                    child: Text(
                      'Sim',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 70,
                  child: GFButton(
                    size: GFSize.SMALL,
                    onPressed: () {
                      Get.back();
                    },
                    shape: GFButtonShape.pills,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: GFColors.WHITE,
                    ),
                    position: GFPosition.end,
                    text: 'Não',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fController.fornecedores != null) {
      Map map = fController.fornecedores;
      var tol = map.values.toList();
      name = tol[widget.index]["name"].toString();
      phone = tol[widget.index]["phone"].toString();
      email = tol[widget.index]["email"].toString();
      cnpj = tol[widget.index]["cnpj"].toString();
      photoUrl = tol[widget.index]["photoUrl"].toString();
      id = tol[widget.index]["fornecedorId"].toString();
    }
    return SingleChildScrollView(
      child: GFListTile(
        margin: EdgeInsets.all(0),
        avatar: GFAvatar(
          backgroundImage: NetworkImage(photoUrl),
        ),
        icon: Row(
          children: [
            // Icon(Icons.edit, color: Colors.orange),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red)),
              onPressed: () {
                remove();
              },
              child: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            ),
          ],
        ),
        titleText: name,
        subTitleText:
            "Telefone: " + phone + "\nE-mail: " + email + "\nCNPJ: " + cnpj,
      ),
    );
  }
}
