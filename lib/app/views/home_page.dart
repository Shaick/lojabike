import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/fcontroller.dart';

import 'drawer_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    //final fController = Get.find<FController>();
    // ignore: unused_local_variable
    final fController = Get.put(FController());
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('Area Administrativa'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset("assets/images/iris.jpg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
