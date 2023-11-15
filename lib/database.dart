import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'opangatimin.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE tukangojek (id INTEGER PRIMARY KEY, nama TEXT, nopol TEXT)');
        await db.execute(
            'CREATE TABLE transaksi (id INTEGER PRIMARY KEY, tukangojek_id INTEGER, harga INTEGER, timestamp TEXT)');
      },
    );
  }

  // Fungsi untuk menambahkan tukang ojek ke dalam database
  static Future<void> tambahTukangOjek(String nama, String nopol) async {
    final Database db = await database;
    await db.rawInsert(
      'INSERT INTO tukangojek(nama, nopol) VALUES(?, ?)',
      [nama, nopol],
    );
  }

  // Fungsi untuk menambahkan transaksi ke dalam database
  static Future<void> tambahTransaksi(int tukangOjekId, int harga) async {
    final Database db = await database;
    await db.rawInsert(
      'INSERT INTO transaksi(tukangojek_id, harga, timestamp) VALUES(?, ?, ?)',
      [tukangOjekId, harga, DateTime.now().toString()],
    );
  }

  // Fungsi untuk mengambil data tukang ojek dari database
  static Future<List<Map<String, dynamic>>> fetchTukangOjekData() async {
    final Database db = await database;
    return await db.query('tukangojek');
  }
}
