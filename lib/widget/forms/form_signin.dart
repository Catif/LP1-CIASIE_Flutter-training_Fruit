import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import '../../class/user.dart';
import '../../provider/user_provider.dart';

class FormSignin extends StatefulWidget {
  const FormSignin({super.key, required this.changeStatusForm});

  final Function changeStatusForm;

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignin> {
  void changeStatusForm(String newStatus) {
    widget.changeStatusForm(newStatus);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User> signin() async {
    try {
      var url = Uri.parse('https://fruits.shrp.dev/auth/login');
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'email': emailController.text,
            'password': passwordController.text,
            'role': 'ca2c1507-d542-4f47-bb63-a9c44a536498'
          }));

      if (response.statusCode == 200) {
        final Map body = json.decode(response.body);
        final Map payload = Jwt.parseJwt(body['data']['access_token']);

        return User(
            id: payload['id'],
            email: emailController.text,
            role: payload['role'] ?? "",
            accessToken: body['data']['access_token'],
            refreshToken: body['data']['refresh_token']);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

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
            signin().then((value) => {
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(value),
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connexion réussie'))),
                });
          },
          child: const Text("Se connecter")),
      const SizedBox(height: 5),
      ElevatedButton(
          onPressed: () {
            changeStatusForm("signup");
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Pas de compte ? S'inscrire"))
    ]));
  }
}
