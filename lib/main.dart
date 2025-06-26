// latihan 14
// import 'package:flutter/material.dart';
// import 'package:minggu_12/latihan14/main_shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: SignInScreen(),
//     );
//   }
// }

// m14- praktek - 1

// import 'package:flutter/material.dart';
// import 'package:minggu_12/M14/product_screen.dart';
// import 'package:minggu_12/M14/provider/product_provider.dart';
// import 'package:minggu_12/latihan14/main_shared_preferences.dart';
// import 'package:provider/provider.dart';

// void main() => runApp(
//   MultiProvider(
//     providers: [ChangeNotifierProvider(create: (context) => ProductProvider())],
//     child: MyApp(),
//   ),
// );

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: ProductScreen(),
//     );
//   }
// }

// m14 - praktek - 1
import 'package:flutter/material.dart';
import 'package:minggu_12/latihan14/main_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minggu_12/M14-2/signin_app_screen.dart';
import 'package:minggu_12/M14-2/home_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username != null && username.isNotEmpty) {
      return const HomeScreen();
    } else {
      return const SigninAppScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Login',
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return snapshot.data as Widget;
          }
        },
      ),
    );
  }
}
