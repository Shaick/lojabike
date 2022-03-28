import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'login_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SplashScreenView(navigateRoute: LoginPage()),
          Center(
            child: Container(
              //margin: EdgeInsets.only(left: 20),
              width: 280,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/iris.jpg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 192),
            child: Center(
              child: Text(
                "Bem Vindo a Loja...",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
