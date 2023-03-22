import 'package:flutter/material.dart';
import 'screen/fruits_master.dart';
import 'class/fruit.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FruitsMaster(),
    );
  }
}
