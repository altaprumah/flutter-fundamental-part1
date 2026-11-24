import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pml/model/pizza.dart';

class HttpHelper {
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  final String baseUrl = "https://ldq4w2.wiremockapi.cloud/";
  final String path = "pizzalist";

  String _handleErrorStatus(int statusCode) {
    if (statusCode == HttpStatus.notFound) {
      return "Error 404: Data atau endpoint tidak ditemukan";
    } else if (statusCode == HttpStatus.internalServerError) {
      return "Error 500: Terjadi kesalahan pada server";
    }
    return "Error $statusCode: Permintaan gagal diproses";
  }

  Future<List<Pizza>> getPizzaList() async {
    try {
      final url = Uri.parse("$baseUrl$path");
      final result = await http.get(url);

      if (result.statusCode == HttpStatus.ok) {
        final jsonDecode = json.decode(result.body) as List<dynamic>;
        return jsonDecode
            .map((pizza) => Pizza.fromJson(pizza as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(_handleErrorStatus(result.statusCode));
      }
    } catch (e) {
      throw Exception("Gagal memuat daftar pizza: $e");
    }
  }

  Future<Pizza> getPizzaByID(String id) async {
    try {
      final url = Uri.parse("$baseUrl$path/$id");
      final result = await http.get(url);

      if (result.statusCode == HttpStatus.ok) {
        final jsonDecode = json.decode(result.body) as Map<String, dynamic>;
        return Pizza.fromJson(jsonDecode);
      } else {
        throw Exception(_handleErrorStatus(result.statusCode));
      }
    } catch (e) {
      throw Exception("Gagal mengambil detail pizza: $e");
    }
  }

  Future<String> postPizza(Pizza pizza) async {
    try {
      final url = Uri.parse("${baseUrl}pizza");
      final result = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pizza.toJson()),
      );

      if (result.statusCode == HttpStatus.created ||
          result.statusCode == HttpStatus.ok) {
        return result.body;
      } else {
        throw Exception(_handleErrorStatus(result.statusCode));
      }
    } catch (e) {
      throw Exception("Gagal menambah data: $e");
    }
  }

  Future<String> putPizza(Pizza pizza) async {
    try {
      final url = Uri.parse("${baseUrl}pizza");
      final result = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pizza.toJson()),
      );

      if (result.statusCode == HttpStatus.ok) {
        return result.body;
      } else {
        throw Exception(_handleErrorStatus(result.statusCode));
      }
    } catch (e) {
      throw Exception("Gagal memperbarui data: $e");
    }
  }

  Future<String> deletePizza(int id) async {
    try {
      final url = Uri.parse("${baseUrl}pizza");
      final result = await http.delete(url);

      if (result.statusCode == HttpStatus.ok ||
          result.statusCode == HttpStatus.noContent) {
        return result.body;
      } else {
        throw Exception(_handleErrorStatus(result.statusCode));
      }
    } catch (e) {
      throw Exception("Gagal menghapus data: $e");
    }
  }
}