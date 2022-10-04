import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../i_unzip.dart';
import '../unzip_repository.dart';
import 'base_sqlite_service.dart';

class SqliteService extends BaseSqliteService {
  String zipName = 'sync.zip';
  String dbName = 'sync.db';

  String zipNameExclusion = 'db.zip';
  String dbNameExclusion = 'exclusions.db';

  @override
  Future<bool> saveDBZip(Uint8List bytes) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirStringPath = dir.path;

    File file = File('$dirStringPath/$zipName');

    if (await file.exists()) {
      await file.delete();
    }

    final dbFile = File('$dirStringPath/sync.db');

    await deleteDatabase(dbFile.path);

    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    await file.writeAsBytes(bytes);

    IUnZip unZip = UnZipRepository();
    await unZip.unzipFile(dirStringPath, zipName);

    return true;
  }

  @override
  Future<Database> openDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirStringPath = dir.path;
    return await openDatabase(join(dirStringPath, dbName));
  }

  @override
  Future closeDB(Database db) async {
    await db.close();
  }

  @override
  Future<bool> saveDBZipExclusion(Uint8List bytes) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirStringPath = dir.path;

    File file = File('$dirStringPath/$zipNameExclusion');

    if (await file.exists()) {
      await file.delete();
    }

    final dbFile = File('$dirStringPath/exclusions.db');

    await deleteDatabase(dbFile.path);

    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    await file.writeAsBytes(bytes);

    IUnZip unZip = UnZipRepository();
    await unZip.unzipFile(dirStringPath, zipNameExclusion);

    return true;
  }

  @override
  Future<Database> openDBExlusion() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirStringPath = dir.path;
    return await openDatabase(join(dirStringPath, dbNameExclusion));
  }
}
