class ItemResponse {
  final String status;
  final String message;
  final List<Item> data;

  ItemResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) {
    return ItemResponse(
      status: json['status'],
      message: json['message'],
      data: List<Item>.from(json['data'].map((item) => Item.fromJson(item))),
    );
  }
}

class Item {
  final int id;
  final String name;
  final String harga;

  Item({required this.id, required this.name, required this.harga});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json['id'], name: json['name'], harga: json['harga']);
  }
}
