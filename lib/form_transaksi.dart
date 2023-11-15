import 'package:flutter/material.dart';
import 'package:opangatimin/database.dart';

class FormTambahTransaksi extends StatelessWidget {
  final TextEditingController tukangOjekIdController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<int>(
              value: null,
              items: [], // Daftar opsi tukang ojek (nama dan ID)
              onChanged: (newValue) {
                tukangOjekIdController.text = newValue.toString();
              },
              decoration: InputDecoration(
                labelText: 'Pilih Tukang Ojek',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await tambahTransaksi(context);
              },
              child: Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> tambahTransaksi(BuildContext context) async {
    if (tukangOjekIdController.text.isEmpty || hargaController.text.isEmpty) {
      // Tampilkan pesan kesalahan jika input kosong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Pastikan semua input terisi dengan benar.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Konversi harga menjadi tipe data integer
    int harga = int.tryParse(hargaController.text) ?? 0;
    int tukangOjekId = int.tryParse(tukangOjekIdController.text) ?? 0;

    await DatabaseHelper.tambahTransaksi(tukangOjekId, harga);
    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }
}
