import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/login_controller.dart';

class SignupPage extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(25),
            children: [
              Hero(
                tag: 'here',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 72,
                  child: Image.asset('assets/images/iris.jpg'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _loginController.nameTextController,
                // ignore: missing_return
                validator: (value) {
                  if (value!.isEmpty || value.length <= 2)
                    return 'Nome muito pequeno';
                },
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Nome...',
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: _loginController.emailTextController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo Obrigatório';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Digite um Email Valido!';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Email...',
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: _loginController.passwordTextController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite uma Senha';
                  } else if (value.length <= 5) {
                    return 'Senha deve ter o minimo de 6 Caracteres!';
                  }
                  return null;
                },
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha...',
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  /*  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.all(12),
                  color: Get.theme.primaryColor, */
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _loginController.register();
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Voltar para Login",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
