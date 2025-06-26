import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minggu_12/M14/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    getDataProduct();
  }

  bool _isLoading = false;
  ProductModel _products = ProductModel();

  bool get isLoading => _isLoading;
  ProductModel get dataProducts => _products;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setProducts(ProductModel val) {
    _products = val;
    notifyListeners();
  }

  Future<void> getDataProduct() async {
    try {
      isLoading = true;
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _products = ProductModel.fromJson(data);
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
    }
  }
}
