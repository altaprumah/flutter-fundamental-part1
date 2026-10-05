import 'package:flutter/material.dart';
import 'package:pml/basic_widgets/image_widget.dart';
import 'package:pml/basic_widgets/text_input.dart';
import 'package:pml/basic_widgets/text_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  DateTime? _dateTime = DateTime.now();

  //void _incrementCounter() {
  //  setState(() {
  //    _counter++;
  //  });
  //}

  void tampilkanDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Dialog"),
      content: const Text("Ini adalah dialog"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_dateTime.toString()),
            MyImageWidget(),
            MyWidget(),
            InputTextWidget(),
            ElevatedButton(
              child: const Text("ubah tanggal"),
              onPressed: () async {
                final DateTime? tanggal = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );

                if (tanggal != null && tanggal != _dateTime) {
                  setState(() {
                    _dateTime = tanggal;
                  });
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => tampilkanDialog(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}