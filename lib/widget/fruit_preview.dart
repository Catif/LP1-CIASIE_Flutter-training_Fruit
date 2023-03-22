import 'package:flutter/material.dart';
import '../class/fruit.dart';
import '../screen/fruits_detail.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import './quantity_badge.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({super.key, required this.fruit});

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 20,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(3),
        child: Image.asset(fruit.imageSrc),
      ),
      trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () => Provider.of<CartProvider>(context, listen: false)
              .addFruit(fruit)),
      tileColor: fruit.color,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(fruit.name),
        Consumer<CartProvider>(
          builder: (context, cart, child) =>
              QuantityBadge(quantity: cart.numberTypeFruitSelected(fruit)),
        ),
      ]),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FruitsDetailsScreen(fruit: fruit)));
      },
    );
  }
}
