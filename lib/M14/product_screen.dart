// import yang dibutuhkan
import 'package:flutter/material.dart';
import 'package:minggu_12/M14/product_widget/product_item.dart';
import 'package:minggu_12/M14/provider/product_provider.dart';
import 'package:minggu_12/M14/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Screen'), centerTitle: true),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = productProvider.dataProducts.products!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ProductDetailScreen(productId: product.id!),
                      ),
                    );
                  },
                  child: ProductItem(product: product),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
