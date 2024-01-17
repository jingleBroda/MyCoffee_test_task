import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'abstract/abstract_db_helper.dart';
import 'model/coffee_canister_set.dart';
import 'model/coffee_recipe.dart';

class DatabaseHelper implements AbstractDataBaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  @override
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo_coffee.db');

    var exists = await databaseExists(path);

    //Копируем Бд
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(url.join("assets", "coffee.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

    }

    var db = await openDatabase(path, readOnly: true);
    return db;
  }

  @override
  Future<List<String>> getAllTables() async {
    var dbClient = await db;
    var tables = await dbClient.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    return tables.map((e) => e['name'] as String).toList();
  }

  // List<Map<String, dynamic>>
  @override
  Future<List<CoffeeRecipe>> getAllCoffeeRecipes() async {
    var dbClient = await db;
    final query = await dbClient.query('recipe');
    return query.map((json) => CoffeeRecipe.fromJson(json)).toList();
  }

  @override
  @protected
  Future<List<CoffeeCanisterSet>> getCoffeeIngredient(int canisterId) async {
    var dbClient = await db;
    final query = await dbClient.rawQuery(
      'SELECT * FROM canisterSet WHERE canisterId = ?',
      [canisterId],
    );

    if (query.isEmpty) {
      return <CoffeeCanisterSet>[CoffeeCanisterSet.empty()];
    } else {
      return query.map((json) => CoffeeCanisterSet.fromJson(json)).toList();
    }
  }

  Future<List<CoffeeCanisterSet>> getCoffeeIngredients(List<int> canisterId) async {
    final result = <CoffeeCanisterSet>[];
    for (var id in canisterId) {
      final query = await getCoffeeIngredient(id);
      result.add(query[0]);
    }
    return result;
  }
}