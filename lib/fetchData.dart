// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'model.dart';

// Future<List<User>> fetchUsers() async {
//   final response = await http.get(
//     Uri.parse('https://randomuser.me/api/?results=10'),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final List users = data['results'];
//     return users.map((json) => User.fromJson(json)).toList();
//   } else {
//     throw Exception('Gagal ambil data user');
//   }
// }
