import 'package:flutter/material.dart';
import 'package:minggu_12/m15/books_provider.dart';
import 'package:minggu_12/m15/books_model.dart';
import 'package:provider/provider.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final hargaController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void clearFields() {
    titleController.clear();
    descController.clear();
    hargaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Data Buku")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Judul Buku'),
                    validator:
                        (val) =>
                            val == null || val.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                    validator:
                        (val) =>
                            val == null || val.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: hargaController,
                    decoration: const InputDecoration(labelText: 'Harga'),
                    keyboardType: TextInputType.number,
                    validator:
                        (val) =>
                            val == null || val.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        bool res = await booksProvider.addNewBook(
                          title: titleController.text,
                          deskripsi: descController.text,
                          harga: int.tryParse(hargaController.text) ?? 0,
                        );
                        if (res) {
                          clearFields();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Buku berhasil ditambahkan'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Tambah Buku"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () async => await booksProvider.getBooks(),
              child: const Text("Ambil Data"),
            ),
            const SizedBox(height: 10),

            booksProvider.isLoading
                ? const CircularProgressIndicator()
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: booksProvider.dataBuku.length,
                  itemBuilder: (context, index) {
                    final book = booksProvider.dataBuku[index];
                    return Card(
                      child: ListTile(
                        title: Text(book.buku ?? '-'),
                        subtitle: Text(book.deskripsi ?? '-'),
                        trailing: Text("Rp ${book.harga ?? 0}"),
                        onTap: () {
                          // isi field untuk update
                          titleController.text = book.buku ?? '';
                          descController.text = book.deskripsi ?? '';
                          hargaController.text = book.harga?.toString() ?? '';

                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text("Update Buku"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          labelText: 'Judul',
                                        ),
                                      ),
                                      TextFormField(
                                        controller: descController,
                                        decoration: const InputDecoration(
                                          labelText: 'Deskripsi',
                                        ),
                                      ),
                                      TextFormField(
                                        controller: hargaController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Harga',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Batal"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    ElevatedButton(
                                      child: const Text("Simpan"),
                                      onPressed: () async {
                                        final updated = BooksModel(
                                          id: book.id,
                                          buku: titleController.text,
                                          deskripsi: descController.text,
                                          harga:
                                              int.tryParse(
                                                hargaController.text,
                                              ) ??
                                              0,
                                        );
                                        await booksProvider.updateBook(updated);
                                        clearFields();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                          );
                        },
                        onLongPress: () async {
                          await booksProvider.deleteBook(book.id ?? '');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Buku berhasil dihapus'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
