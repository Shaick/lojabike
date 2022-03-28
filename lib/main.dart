import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  await GetStorage.init('login_firebase');
  // GetStorage box = GetStorage('login_firebase');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: "Bike Arco Iris e Ferragens",
      getPages: AppPages.routes,
      initialRoute: Routes.INITIAL,
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: Colors.black,
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      themeMode: ThemeMode.system,
      locale: Locale('pt', 'BR'),
    ),
  );
}
