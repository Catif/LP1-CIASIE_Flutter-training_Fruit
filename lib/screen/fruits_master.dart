import 'package:flutter/material.dart';
import '../class/fruit.dart';
import '../widget/fruit_preview.dart';
import '../screen/cart_screen.dart';
import '../provider/cart_provider.dart';
import 'package:provider/provider.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({super.key});

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  _FruitsMasterState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Consumer<CartProvider>(
            builder: (BuildContext context, CartProvider cart, widget) =>
                Text("Total panier : ${cart.sum.toStringAsFixed(2)} €"),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
          ]),
      body: FutureBuilder<List<Fruit>>(
        future: Provider.of<CartProvider>(context, listen: false).fetchFruits(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FruitPreview(fruit: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
