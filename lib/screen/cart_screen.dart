import 'package:flutter/material.dart';
import '../class/fruit.dart';
import '../widget/fruit_cart.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

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
      body: Consumer<CartProvider>(
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
    );
  }
}
