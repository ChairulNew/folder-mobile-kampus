class User {
  final String name;
  final String email;
  final String photo;

  User({required this.name, required this.email, required this.photo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: "${json['name']['first']} ${json['name']['last']}",
      email: json['email'],
      photo: json['picture']['large'],
    );
  }
}
