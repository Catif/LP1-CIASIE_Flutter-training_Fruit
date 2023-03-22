import 'package:flutter/material.dart';
import '../provider/cart_provider.dart';
import 'package:provider/provider.dart';

class FilterFruit extends StatefulWidget {
  const FilterFruit({super.key});

  @override
  State<FilterFruit> createState() => _FilterFruitState();
}

class _FilterFruitState extends State<FilterFruit> {
  List<String> list = ['Tous', 'Printemps', 'Eté', 'Automne', 'Hiver'];
  String dropdownValue = 'Tous';

  void onChanged(String? value) {
    Provider.of<CartProvider>(context, listen: false).setFilter(value!);
    setState(() {
      dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Filtre : "),
        DropdownButton(
            value: dropdownValue,
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged),
      ],
    );
  }
}
