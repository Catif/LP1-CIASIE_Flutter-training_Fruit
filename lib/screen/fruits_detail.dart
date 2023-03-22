import 'package:flutter/material.dart';
import '../class/fruit.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widget/quantity_badge.dart';

class FruitsDetailsScreen extends StatelessWidget {
  const FruitsDetailsScreen({super.key, required this.fruit});

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(fruit.name, style: const TextStyle(fontSize: 18)),
          backgroundColor: fruit.color,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(fruit.imageSrc, width: 200, height: 200),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Origine : ${fruit.location.country}"),
                    Text("Saison : ${fruit.season}"),
                    Text("Stock : ${fruit.stock}"),
                    Text("Tarif à l'unité : ${fruit.price} €"),
                    Row(children: [
                      Text("Quantité : "),
                      Consumer<CartProvider>(
                        builder: (context, cart, child) => QuantityBadge(
                            quantity: cart.numberTypeFruitSelected(fruit)),
                      ),
                    ]),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addFruit(fruit);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        child: const Text("Ajouter au panier")),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeFruits(fruit);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: const Text("Supprimer de mon panier")),
                  ],
                ),
              ],
            ),
            Expanded(
                child: FlutterMap(
              options: MapOptions(
                center: LatLng(fruit.location.coordinates[1],
                    fruit.location.coordinates[0]),
                zoom: 5.5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                  maxZoom: 20,
                  subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: LatLng(fruit.location.coordinates[1],
                          fruit.location.coordinates[0]),
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        )));
  }
}
