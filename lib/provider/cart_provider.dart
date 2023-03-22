import 'package:flutter/material.dart';
import 'package:magasin_fruit/class/fruit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  final List<Fruit> _items = [];
  double _sum = 0;

  List<Fruit> get items => _items;
  double get sum => _sum;

  void addFruit(Fruit item, [bool notified = true]) {
    _items.add(item);
    _sum = _sum + item.price;

    notifyListeners();
  }

  void removeFruit(Fruit item, [bool notified = true]) {
    _items.remove(item);
    _sum = _sum - item.price;

    notifyListeners();
  }

  void removeFruits(Fruit item, [bool notified = true]) {
    int i = 0;
    while (_items.contains(item)) {
      _items.remove(item);
      _sum = _sum - item.price;
      i++;
    }

    notifyListeners();
  }

  void clearCart([bool notified = true]) {
    _items.clear();
    _sum = 0;

    notifyListeners();
  }

  int numberTypeFruitSelected(Fruit item) {
    int i = 0;
    _items.forEach((fruit) {
      if (fruit.name == item.name) {
        i++;
      }
    });

    return i;
  }

  Future<List<Fruit>> fetchFruits() async {
    List<Fruit> fruitsAPI = [];

    try {
      var url = Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*');
      var response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 304) {
        final responseJSON = jsonDecode(response.body);

        responseJSON['data'].forEach((fruit) {
          fruitsAPI.add(Fruit.fromJson(fruit));
        });
      } else {
        throw Exception('Erreur de chargement des fruits.');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }

    return fruitsAPI;
  }
}
