import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'provider/cart_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), child: MyApp()));
}
