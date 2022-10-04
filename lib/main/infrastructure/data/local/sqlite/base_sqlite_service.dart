import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';

abstract class BaseSqliteService {
  Future saveDBZip(Uint8List bytes);
  Future saveDBZipExclusion(Uint8List bytes);
  Future<dynamic> openDB();
  Future<dynamic> openDBExlusion();
  Future<dynamic> closeDB(Database db);
}
