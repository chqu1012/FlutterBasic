import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_flutter_wiki/model/FlutterCategory.dart';
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

  // Create the database and the pages table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'wiki.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE pages(id INTEGER PRIMARY KEY, title TEXT, content TEXT, created TEXT, updated TEXT, categoryId INTEGER)");
      await db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, created TEXT, updated TEXT)");
    });
  }

  // Insert pages on database
  insertCategory(FlutterCategory newCategory) async {
    var exist = await existCategory(newCategory.id);
    if (exist == false) {
      final db = await database;
      final res = await db.insert('categories', newCategory.toJson());
      return res;
    } else {
      return newCategory;
    }
  }

  // Insert pages on database
  insertPage(FlutterPage newPage) async {
    var exist = await existPage(newPage.id);
    if (exist == false) {
      final db = await database;
      final res = await db.insert('Pages', newPage.toJson());
      return res;
    } else {
      return newPage;
    }
  }

  Future<bool> existCategory(int id) async {
    var dbclient = _database;
    int count = Sqflite.firstIntValue(await dbclient
        .rawQuery("SELECT COUNT(*) FROM Categories WHERE id=$id"));
    return count == 1;
  }

  Future<bool> existPage(int id) async {
    var dbclient = _database;
    int count = Sqflite.firstIntValue(
        await dbclient.rawQuery("SELECT COUNT(*) FROM Pages WHERE id=$id"));
    return count == 1;
  }

  // Delete all pages
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM pages');

    return res;
  }

  Future<List<FlutterPage>> findAllPages() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM pages");

    List<FlutterPage> list =
        res.isNotEmpty ? res.map((c) => FlutterPage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<FlutterCategory>> findAllCategories() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM categories");

    List<FlutterCategory> list = res.isNotEmpty
        ? res.map((c) => FlutterCategory.fromJson(c)).toList()
        : [];
    return list;
  }
}
