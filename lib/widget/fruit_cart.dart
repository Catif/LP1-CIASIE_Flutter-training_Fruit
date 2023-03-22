import 'package:flutter/material.dart';
import '../class/fruit.dart';

class FruitCart extends StatelessWidget {
  const FruitCart(
      {super.key, required this.fruit, required this.onButtonRemoveFruit});

  final Fruit fruit;
  final Function onButtonRemoveFruit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.remove_shopping_cart),
        onPressed: () => onButtonRemoveFruit(fruit),
      ),
      title: Text("${fruit.name} (${fruit.price.toString()} €)"),
    );
  }
}
