import 'package:flutter/material.dart';

class LocationFruit {
  String country;
  String countryCode;
  List coordinates;
  String type;

  LocationFruit(this.country, this.countryCode, this.coordinates, this.type);

  LocationFruit.fromJson(Map<String, dynamic> json)
      : country = json['name'],
        countryCode = json['code'],
        coordinates = json['location']['coordinates'],
        type = json['location']['type'];
}
