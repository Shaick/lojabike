import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:lojabike/app/controller/fcontroller.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';
import 'package:lojabike/app/routes/app_routes.dart';

import 'fornecedor_page.dart';

class FornecedoresPage extends StatelessWidget {
  // final fController = Get.find<FController>();
  final entryProvider = EntryProvider();
  final i = 0.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FController>(
      init: FController(),
      builder: (_) {
        _.onReady();
        return Scaffold(
          floatingActionButton: Obx(() => FloatingActionButton(
                onPressed: () {
                  i.value = _.fornecedores.length;
                },
                child: Text(i.obs.toString()),
              )),
          appBar: GFAppBar(
            actions: [
              GestureDetector(
                child: Icon(FontAwesomeIcons.plusCircle),
                onTap: () {
                  Get.toNamed(Routes.CADFORNECEDOR);
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
            searchBar: true,
            title: Text("Fornecedores"),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return FornecedorPage(index);
            },
            itemCount: _.fornecedores != null ? _.fornecedores.length : 4,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
          ),
        );
      },
    );
  }
}
