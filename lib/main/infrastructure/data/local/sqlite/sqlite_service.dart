import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'base_sqlite_service.dart';
import 'package:flutter/services.dart';

import 'dart:io' as io;

class SqliteService extends BaseSqliteService {
  String dbName = 'sync.db';

  @override
  Future<Database> openDB() async {
    //  var databasesPath = await getDatabasesPath();
    //  var path = join(databasesPath, dbName);
    Database db;

//
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPathEnglish = join(applicationDirectory.path, "survey.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "survey.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    db = await openDatabase(dbPathEnglish);
    return db;
  }

//
  //verifica si existe la base de datos en la carpeta raiz
  /*   var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copia la base de datos de la carepa assets a la carpeta raiz
      ByteData data = await rootBundle.load(join("assets", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    db = await openDatabase(path, readOnly: true);
    return db;
  }*/

  @override
  Future closeDB(Database db) async {
    await db.close();
  }
}
