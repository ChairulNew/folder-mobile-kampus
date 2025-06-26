import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoading = true;
  Map<String, dynamic>? product;

  @override
  void initState() {
    super.initState();
    fetchProductDetail();
  }

  Future<void> fetchProductDetail() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/${widget.productId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        product = json.decode(response.body);
        isLoading = false;
      });
    } else {
      // Error handling
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengambil data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : product == null
              ? const Center(child: Text("Data tidak ditemukan"))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Brand: ${product!['brand']}"),
                    const SizedBox(height: 10),
                    Text("Harga: \$${product!['price']}"),
                    const SizedBox(height: 10),
                    Text("Deskripsi: ${product!['description']}"),
                    const SizedBox(height: 20),
                    Image.network(product!['thumbnail']),
                  ],
                ),
              ),
    );
  }
}
