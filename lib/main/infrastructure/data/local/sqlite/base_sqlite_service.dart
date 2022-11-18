import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';

abstract class BaseSqliteService {
  Future<dynamic> openDB();
  Future<dynamic> closeDB(Database db);
}
