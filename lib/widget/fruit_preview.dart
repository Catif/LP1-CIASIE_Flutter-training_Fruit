import 'package:flutter/material.dart';
import '../class/fruit.dart';
import '../screen/fruits_detail.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({super.key, required this.fruit});

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(fruit.imageSrc),
      trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () => Provider.of<CartProvider>(context, listen: false)
              .addFruit(fruit)),
      tileColor: fruit.color,
      title: Text(fruit.name),
      subtitle: Consumer<CartProvider>(
        builder: (context, cart, child) => Text(
            "prix: ${fruit.price.toString()} € | quantité: ${cart.numberTypeFruitSelected(fruit)}"),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FruitsDetailsScreen(fruit: fruit)));
      },
    );
  }
}
