import 'package:flutter/material.dart';
import 'model/pizza.dart';
import 'services/local_storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Data - Althaf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalStorageService _storageService = LocalStorageService();
  final TextEditingController _tokenController = TextEditingController();

  List<Pizza> _pizzas = [];
  bool _useBrokenJson = false;
  int _appCounter = 0;
  String _fileContent = '';
  String _savedToken = '';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _loadPizzas();

    int currentCount = await _storageService.getAppCounter();
    currentCount++;
    await _storageService.saveAppCounter(currentCount);

    setState(() {
      _appCounter = currentCount;
    });
  }

  Future<void> _loadPizzas() async {
    final path = _useBrokenJson
        ? 'assets/pizzalist_broken.json'
        : 'assets/pizzalist.json';
    final loadedPizzas = await _storageService.loadPizzasFromAsset(path);
    setState(() {
      _pizzas = loadedPizzas;
    });
  }

  Future<void> _handleWriteAndReadFile() async {
    final String jsonString = _storageService.convertPizzasToJson(_pizzas);
    await _storageService.writePizzaFile(jsonString);
    final String content = await _storageService.readPizzaFile();
    setState(() {
      _fileContent = content;
    });
  }

  Future<void> _handleSaveToken() async {
    await _storageService.saveUserToken(_tokenController.text);
    final String token = await _storageService.getUserToken();
    setState(() {
      _savedToken = token;
    });
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Challenge - Althaf'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SharedPreferences
            Text('App Opened: $_appCounter times',
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(height: 24),

            // 2. Toggle Normal vs Broken JSON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data Pizza (${_useBrokenJson ? "Broken JSON" : "Normal JSON"})',
                    style: Theme.of(context).textTheme.titleMedium),
                Switch(
                  value: _useBrokenJson,
                  onChanged: (val) {
                    setState(() => _useBrokenJson = val);
                    _loadPizzas();
                  },
                ),
              ],
            ),
            ..._pizzas.map((pizza) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: pizza.imageUrl.isNotEmpty
                      ? Image.asset(
                          pizza.imageUrl,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(Icons.local_pizza),
                        )
                      : const Icon(Icons.broken_image),
                  title: Text('${pizza.id}. ${pizza.pizzaName}'),
                  subtitle: Text('${pizza.description} - \$${pizza.price}'),
                )),
            const Divider(height: 24),

            // 3. File I/O
            ElevatedButton(
              onPressed: _handleWriteAndReadFile,
              child: const Text('Write & Read Pizza File'),
            ),
            if (_fileContent.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Isi File (${_fileContent.length} chars): $_fileContent',
                  maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
            const Divider(height: 24),

            // 4. Secure Storage
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Masukkan User Token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _handleSaveToken,
              child: const Text('Save & Read Token'),
            ),
            if (_savedToken.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Token Tersimpan: $_savedToken'),
            ],
          ],
        ),
      ),
    );
  }
}