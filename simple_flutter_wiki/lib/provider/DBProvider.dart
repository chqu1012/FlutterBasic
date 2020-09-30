import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'wiki.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE pages(id INTEGER PRIMARY KEY, title TEXT, content TEXT, created TEXT, updated TEXT)");
    });
  }

  // Insert pages on database
  createEmployee(FlutterPage newPage) async {
    await deleteAllPages();
    final db = await database;
    final res = await db.insert('Pages', newPage.toJson());

    return res;
  }

  // Delete all pages
  Future<int> deleteAllPages() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM pages');

    return res;
  }

  Future<List<FlutterPage>> getAllPages() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM pages");

    List<FlutterPage> list =
        res.isNotEmpty ? res.map((c) => FlutterPage.fromJson(c)).toList() : [];

    return list;
  }
}
