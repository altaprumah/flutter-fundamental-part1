import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/pizza.dart';

class LocalStorageService {
  static const String _counterKey = 'appCounter';
  static const String _tokenKey = 'userToken';
  static const String _pizzaFileName = 'pizzas.txt';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Membaca dan mem-parsing file JSON dari assets secara aman
  Future<List<Pizza>> loadPizzasFromAsset(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final dynamic decoded = jsonDecode(jsonString);

      if (decoded is List) {
        final List<Pizza> result = [];
        for (final item in decoded) {
          if (item is Map<String, dynamic>) {
            result.add(Pizza.fromJson(item));
          }
        }
        return result;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Mengonversi List<Pizza> kembali ke JSON String
  String convertPizzasToJson(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }

  // Menyimpan counter ke SharedPreferences
  Future<bool> saveAppCounter(int count) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setInt(_counterKey, count);
    } catch (e) {
      return false;
    }
  }

  // Mengambil counter dari SharedPreferences
  Future<int> getAppCounter() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_counterKey) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // Mendapatkan referensi file di direktori Documents
  Future<File> _getLocalPizzaFile() async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    return File('${docDir.path}/$_pizzaFileName');
  }

  // Menulis string ke file lokal
  Future<bool> writePizzaFile(String content) async {
    try {
      final File file = await _getLocalPizzaFile();
      await file.writeAsString(content);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Membaca string dari file lokal
  Future<String> readPizzaFile() async {
    try {
      final File file = await _getLocalPizzaFile();
      if (await file.exists()) {
        return await file.readAsString();
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  // Menyimpan token sensitif ke Secure Storage
  Future<bool> saveUserToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Mengambil token sensitif dari Secure Storage
  Future<String> getUserToken() async {
    try {
      return await _secureStorage.read(key: _tokenKey) ?? '';
    } catch (e) {
      return '';
    }
  }
}