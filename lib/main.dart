import 'dart:convert';
import 'package:flutter/material.dart';
import './model/pizza.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON - Farrel',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  Future<List<Pizza>> readJsonFile() async {
    try {
      String myString = await DefaultAssetBundle.of(context)
          .loadString('assets/pizzalist.json');
      List pizzaMapList = jsonDecode(myString);
      List<Pizza> myPizzas = [];
      for (var pizza in pizzaMapList) {
        Pizza myPizza = Pizza.fromJson(pizza);
        myPizzas.add(myPizza);
      }

      String json = convertToJSON(myPizzas);
      print(json);

      return myPizzas;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON - Farrel')),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                myPizzas[index].imageUrl,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.local_pizza, size: 40),
              ),
            ),
            title: Text(myPizzas[index].pizzaName),
            subtitle: Text(myPizzas[index].description),
            trailing: Text('\$${myPizzas[index].price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}