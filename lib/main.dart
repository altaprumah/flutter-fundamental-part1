import 'package:flutter/material.dart';
import 'package:pml/api/http_helper.dart';
import 'package:pml/model/pizza.dart';
import 'package:pml/pages/detail.dart';
import 'package:pml/pages/pizza_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESTful API - Farrel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JSON - Farrel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: HttpHelper().getPizzaList(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (data.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Terjadi kesalahan: ${data.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (data.connectionState == ConnectionState.done &&
                data.data != null) {
              if (data.data!.isEmpty) {
                return const Text("Data pizza kosong");
              }

              return ListView.builder(
                itemCount: data.data?.length,
                itemBuilder: (context, index) {
                  final pizza = data.data![index];
                  return Dismissible(
                    key: Key(pizza.id.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) async {
                      int? idToDelete = pizza.id;
                      final messenger = ScaffoldMessenger.of(context);

                      setState(() {
                        data.data!.removeAt(index);
                      });

                      if (idToDelete != null) {
                        try {
                          final res = await HttpHelper().deletePizza(idToDelete);
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text("Sukses dihapus: $res"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString().replaceAll('Exception: ', ''),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: ListTile(
                      title: Text(
                        '${pizza.pizzaName ?? ''} (${pizza.category ?? ''})',
                      ),
                      subtitle: Text(
                        '${pizza.description ?? ''} - € ${pizza.price ?? 0}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => PizzaFormScreen(
                                pizza: pizza,
                                isNew: false,
                              ),
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => DetailPizza(
                              id: pizza.id.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const Text("Tidak ada data");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => PizzaFormScreen(
                pizza: Pizza(),
                isNew: true,
              ),
            ),
          );
        },
      ),
    );
  }
}