import 'package:flutter/material.dart';
import 'package:magasin_fruit/class/fruit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  Future<List<Fruit>> _fruits = Future.value([]);
  String _filter = 'Tous';
  final List<Fruit> _items = [];
  double _sum = 0;

  List<Fruit> get items => _items;
  String get filter => _filter;
  set filter(String filter) => _filter = filter;
  double get sum => _sum;

  CartProvider() {
    fetchFruits();
  }

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
    while (_items.contains(item)) {
      _items.remove(item);
      _sum = _sum - item.price;
    }

    notifyListeners();
  }

  void clearCart([bool notified = true]) {
    _items.clear();
    _sum = 0;

    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
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

  void fetchFruits() async {
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
      throw Exception(e);
    }

    _fruits = Future.value(fruitsAPI);
    notifyListeners();
  }

  Future<List<Fruit>> getFruits(String filter) async {
    if (filter == 'Tous') {
      return _fruits;
    } else {
      return _fruits.then((listFruits) {
        return listFruits
            .where((fruit) => fruit.season == filter)
            .toList(growable: false);
      });
    }
  }
}
