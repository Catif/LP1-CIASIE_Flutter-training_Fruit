import 'package:flutter/material.dart';
import 'location_fruit.dart';

class Fruit {
  String name;
  double price;
  String imageSrc;
  Color color;
  int stock;
  String season;
  LocationFruit location;

  Fruit(this.name, this.price, this.imageSrc, this.color, this.stock,
      this.season, this.location);

  Fruit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        imageSrc = "/images/${json['image']}",
        color = Color(
            int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
        stock = json['stock'],
        season = json['season'],
        location = LocationFruit.fromJson(json['origin']);
}
