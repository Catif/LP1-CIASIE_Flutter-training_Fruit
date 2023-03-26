import 'package:flutter/material.dart';
import 'package:magasin_fruit/widget/forms/form_cart.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/user_provider.dart';

import '../widget/fruit_cart.dart';

import '../widget/account.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Consumer<CartProvider>(
              builder: (context, cart, child) =>
                  Text("Total panier : ${cart.sum.toStringAsFixed(2)} €"),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed:
                    Provider.of<CartProvider>(context, listen: false).clearCart,
              ),
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 500,
              child: Consumer<CartProvider>(
                builder: (context, cart, child) => ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return FruitCart(
                      fruit: cart.items[index],
                      onButtonRemoveFruit: cart.removeFruit,
                    );
                  },
                ),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, user, child) {
                if (user.isLogged) {
                  return const Account();
                } else {
                  return const FormCart();
                }
              },
            ),
          ],
        ));
  }
}
