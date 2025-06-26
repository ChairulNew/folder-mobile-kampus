import 'package:flutter/material.dart';
import 'package:minggu_12/M14/model/product_model.dart';

class ProductItem extends StatelessWidget {
  final Products product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(product.images![0], height: 80, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(product.title ?? "-"),
            Text('\$${product.price}'),
          ],
        ),
      ),
    );
  }
}
