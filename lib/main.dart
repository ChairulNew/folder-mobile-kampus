import 'package:flutter/material.dart';
import 'package:minggu_12/M14/product_screen.dart';
import 'package:minggu_12/M14/provider/product_provider.dart';
import 'package:minggu_12/latihan14/main_shared_preferences.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ProductProvider())],
    child: MyApp(), // ⬅️ Taruh di sini, bukan di dalam ChangeNotifierProvider
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          ProductScreen(), // atau ganti ke main_shared_preferences() jika perlu
    );
  }
}
