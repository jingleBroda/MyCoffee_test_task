import 'package:sqflite/sqflite.dart';

import 'db_dao.dart';

abstract class AbstractDataBaseHelper implements CoffeeDao {
  Future<Database> initDb();
}