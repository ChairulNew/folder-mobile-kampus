import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minggu_12/m15/books_model.dart';

class BooksProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  List<BooksModel> _dataBuku = [];
  List<BooksModel> get dataBuku => _dataBuku;
  set setDataBuku(val) {
    _dataBuku.add(val);
    notifyListeners();
  }

  getBooks() async {
    try {
      setLoading = true;
      await db.collection('books').get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          setDataBuku = BooksModel.fromJson(element.data());
        });
      });
    } catch (e) {
      print('Error while fetching data: $e');
    } finally {
      setLoading = false;
    }
  }

  // Tambahkan di dalam BooksProvider
  Future<void> deleteBook(String id) async {
    try {
      await db.collection('books').doc(id).delete();
      print('✅ Buku berhasil dihapus');
      await getBooks(); // refresh list
    } catch (e) {
      print('❌ Gagal hapus buku: $e');
    }
  }

  Future<void> updateBook(BooksModel updatedBook) async {
    try {
      await db
          .collection('books')
          .doc(updatedBook.id)
          .update(updatedBook.toJson());
      print('✅ Buku berhasil diupdate');
      await getBooks(); // refresh list
    } catch (e) {
      print('❌ Gagal update buku: $e');
    }
  }

  Future<bool> addNewBook({
    required String title,
    required String deskripsi,
    required int harga,
  }) async {
    try {
      final docRef = db.collection('books').doc();
      BooksModel books = BooksModel(
        id: docRef.id,
        buku: title,
        deskripsi: deskripsi,
        harga: harga,
      );
      await db.collection('books').doc(docRef.id).set(books.toJson());
      print('✅ Buku berhasil ditambah');
      return true;
    } catch (e) {
      print('❌ Error saat tambah buku: $e');
      return false;
    }
  }
}
