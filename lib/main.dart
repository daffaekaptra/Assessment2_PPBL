import 'package:flutter/material.dart';
import 'package:opangatimin/database.dart';
import 'package:opangatimin/form_driver.dart';
import 'package:opangatimin/form_transaksi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OPANGATIMIN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/tambah_tukang_ojek': (context) => FormTambahTukangOjek(),
        '/tambah_transaksi': (context) => FormTambahTransaksi(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _tukangOjekData;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _tukangOjekData = DatabaseHelper.fetchTukangOjekData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OPANGATIMIN'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _tukangOjekData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada data tukang ojek'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var tukangOjek = snapshot.data![index];
                return ListTile(
                  title: Text(tukangOjek['nama']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nomor Polisi: ${tukangOjek['nopol']}'),
                      // Tambahkan informasi lainnya jika diperlukan
                    ],
                  ),
                  onTap: () {
                    // Navigasi ke halaman detail tukang ojek
                    Navigator.pushNamed(context, '/detail_tukang_ojek',
                        arguments: tukangOjek);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tambah_tukang_ojek');
            },
            tooltip: 'Tambah Tukang Ojek',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tambah_transaksi');
            },
            tooltip: 'Tambah Transaksi',
            child: Icon(Icons.attach_money),
          ),
        ],
      ),
    );
  }
}
