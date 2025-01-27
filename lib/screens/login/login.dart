import 'package:flutter/material.dart';
import 'package:flutter_mobile/screens/login/widgets/input_login.dart';
import 'package:flutter_mobile/screens/login/widgets/text_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          // alignment: Alignment.center,
          width: 350,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: [Colors.lightBlue, Color.fromARGB(255, 242, 236, 238)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
          ),
          child: const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: TextLogin(
                  text: "Login",
                  fontText: FontWeight.bold,
                  sizeText: 25,
                ),
              ),
              InputLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
