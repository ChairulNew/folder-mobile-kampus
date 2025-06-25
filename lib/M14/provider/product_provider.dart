import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minggu_12/M14/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    getDataProduct();
  }

  bool _isLoading = false;
  ProductModel _products = ProductModel();

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProductModel get dataProducts => _products;
  set setProducts(val) {
    _products = val;
    notifyListeners();
  }

  Future<void> getDataProduct() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
      } else {}
    } catch (e) {}
  }
}
