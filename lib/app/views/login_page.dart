import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojabike/app/controller/login_controller.dart';
import 'package:lojabike/app/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //final LoginController _loginController = Get.find<LoginController>();
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                height: 36,
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
                height: 8,
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
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  child: Text(
                    "Acessar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _loginController.login();
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Esqueceu a Senha?",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.SIGNUP);
                },
                child: Text(
                  "Cadastrar-se?",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
