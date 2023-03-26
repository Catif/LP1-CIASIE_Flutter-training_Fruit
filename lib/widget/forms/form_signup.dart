import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormSignup extends StatefulWidget {
  const FormSignup({super.key, required this.changeStatusForm});

  final Function changeStatusForm;

  @override
  State<FormSignup> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignup> {
  void changeStatusForm(String newStatus) {
    widget.changeStatusForm(newStatus);
  }

  Future<bool> signup() async {
    try {
      var response = await http.post(Uri.parse('https://fruits.shrp.dev/users'),
          headers: <String, String>{"Content-Type": "application/json"},
          body: json.encode({
            'email': emailController.text,
            'password': passwordController.text,
          }));

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          hintText: "Email",
        ),
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: passwordController,
        decoration: const InputDecoration(
          hintText: "Mot de passe",
        ),
        obscureText: true,
      ),
      const SizedBox(height: 15),
      ElevatedButton(
          onPressed: () {
            signup().then((booleanForm) => {
                  if (booleanForm)
                    {
                      changeStatusForm("signin"),
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Inscription réussie'),
                        ),
                      )
                    }
                });
          },
          child: const Text("M'inscrire")),
      const SizedBox(height: 5),
      ElevatedButton(
          onPressed: () {
            changeStatusForm("signin");
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Déjà un compte ? Se connecter"))
    ]));
  }
}
