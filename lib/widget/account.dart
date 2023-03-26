import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../class/user.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void logout() {
    Provider.of<UserProvider>(context, listen: false).setUser(
        User(id: '', email: '', role: '', accessToken: '', refreshToken: ''));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Déconnexion réussie'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person),
          Consumer<UserProvider>(
              builder: (context, userConsumer, child) =>
                  Text(userConsumer.user.email)),
        ],
      ),
      ElevatedButton(
        onPressed: logout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text('Déconnexion'),
      ),
    ]);
  }
}
