import 'package:flutter/material.dart';
import 'package:pml/api/http_helper.dart';
import 'package:pml/model/pizza.dart';

class PizzaFormScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;

  const PizzaFormScreen({
    super.key,
    required this.pizza,
    required this.isNew,
  });

  @override
  State<PizzaFormScreen> createState() => _PizzaFormScreenState();
}

class _PizzaFormScreenState extends State<PizzaFormScreen> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  final TextEditingController txtCategory = TextEditingController();

  String operationResult = '';
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isNew) {
      txtId.text = widget.pizza.id?.toString() ?? '';
      txtName.text = widget.pizza.pizzaName ?? '';
      txtDescription.text = widget.pizza.description ?? '';
      txtPrice.text = widget.pizza.price?.toString() ?? '';
      txtImageUrl.text = widget.pizza.imageUrl ?? '';
      txtCategory.text = widget.pizza.category ?? '';
    }
  }

  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    txtCategory.dispose();
    super.dispose();
  }

  Future<void> savePizza() async {
    setState(() {
      isLoading = true;
      operationResult = '';
    });

    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text),
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text),
      imageUrl: txtImageUrl.text,
      category: txtCategory.text,
    );

    try {
      final String result = await (widget.isNew
          ? helper.postPizza(pizza)
          : helper.putPizza(pizza));

      if (!mounted) return;
      setState(() {
        isError = false;
        operationResult = 'Sukses: $result';
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isNew
                ? 'Berhasil menambahkan pizza!'
                : 'Berhasil memperbarui pizza!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isError = true;
        operationResult = e.toString().replaceAll('Exception: ', '');
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(operationResult),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? 'New Pizza - Farrel' : 'Edit Pizza - Farrel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (operationResult.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isError ? Colors.red[100] : Colors.green[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    operationResult,
                    style: TextStyle(
                      color: isError ? Colors.red[900] : Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              TextField(
                controller: txtId,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Insert ID'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: txtName,
                decoration: const InputDecoration(hintText: 'Insert Pizza Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: txtDescription,
                decoration: const InputDecoration(hintText: 'Insert Description'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: txtPrice,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(hintText: 'Insert Price'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(hintText: 'Insert Image Url'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: txtCategory,
                decoration: const InputDecoration(hintText: 'Insert Category'),
              ),
              const SizedBox(height: 32),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: savePizza,
                      child: Text(widget.isNew ? 'Send Post' : 'Send Put'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}