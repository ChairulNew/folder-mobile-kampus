class BooksModel {
  String? id;
  String? buku;
  String? deskripsi;
  int? harga;

  BooksModel({this.id, this.buku, this.deskripsi, this.harga});

  BooksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buku = json['buku'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['buku'] = this.buku;
    data['deskripsi'] = this.deskripsi;
    data['harga'] = this.harga;
    return data;
  }
}
