import 'package:flutter/material.dart';
import 'package:opangatimin/database.dart';

class FormTambahTukangOjek extends StatelessWidget {
final TextEditingController namaController = TextEditingController();
final TextEditingController nopolController = TextEditingController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Tambah Tukang Ojek'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: namaController,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: nopolController,
            decoration: InputDecoration(
              labelText: 'Nomor Polisi',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await tambahTukangOjek(context);
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    ),
  );
}

Future<void> tambahTukangOjek(BuildContext context) async {
  await DatabaseHelper.tambahTukangOjek(
      namaController.text, nopolController.text);
  // Navigasi kembali ke halaman sebelumnya
  Navigator.pop(context);
}
}