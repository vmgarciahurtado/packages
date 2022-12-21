import 'dart:convert';

import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_segmentation_repository.dart';
import '../domain/model/segmentation.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class SegmentationRepositorySqlite extends ISegmentationRepository {
  @override
  Future<Segmentation> getSegmentation(String codeParam) async {
    late Segmentation segmentation;
    try {
      BaseSqliteService baseSqliteService = SqliteService();
      Database db = await baseSqliteService.openDB();
      String statement =
          "SELECT dynamic_value_segmentation FROM segmentation WHERE cod_param = $codeParam";
      List<Map> list = await db.rawQuery(statement);
      for (var item in list) {
        var segmentationJson = jsonDecode(item['dynamic_value_segmentation']);
        var segmentationDecode = Segmentation.fromJson(segmentationJson);
        segmentation = Segmentation(
            tipologia: segmentationDecode.tipologia,
            canal: segmentationDecode.canal,
            subCanal: segmentationDecode.subCanal,
            segmento: segmentationDecode.segmento);
      }
      return segmentation;
    } catch (e) {
      Get.printError(info: "$e");
      return segmentation;
    }
  }

  @override
  Future<String> getSegment(String typeSurvey, int weighting) async {
    String segment = '';
    BaseSqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    String statement = '''SELECT code_segment 
           FROM segment_classification 
           WHERE type = '$typeSurvey' AND $weighting > _from  ORDER BY _from  DESC LIMIT 1 ''';
    List<Map> list = await db.rawQuery(statement);

    if (list.isEmpty) {
      if (weighting <= await getMinSegmentValue(typeSurvey)) {
        segment = await getMinSegmentCode(typeSurvey);
      } else {
        segment = "";
      }
    } else {
      segment = list.map((e) => e['code_segment']).first;
    }

    return segment;
  }

  Future<int> getMinSegmentValue(String typeSurvey) async {
    int segment = 0;
    BaseSqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    String statement = '''SELECT _from 
           FROM segment_classification 
           WHERE type = '$typeSurvey'  ORDER BY _from  ASC LIMIT 1 ''';
    List<Map> list = await db.rawQuery(statement);
    segment = list.map((e) => e['_from']).first;
    return segment;
  }

  Future<String> getMinSegmentCode(String typeSurvey) async {
    String segment = '';
    BaseSqliteService sqliteService = SqliteService();
    Database db = await sqliteService.openDB();

    String statement = '''SELECT code_segment 
           FROM segment_classification 
           WHERE type = '$typeSurvey'  ORDER BY _from  ASC LIMIT 1 ''';
    List<Map> list = await db.rawQuery(statement);
    segment = list.map((e) => e['code_segment']).first;
    return segment;
  }

  @override
  Future<String> getNameSegment(String segment) async {
    String nameSegment = '';
    try {
      BaseSqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();
      String statement = '''SELECT name 
           FROM segmentation_description 
           WHERE code = '$segment' AND type = 'tipologia' ''';
      List<Map> list = await db.rawQuery(statement);
      nameSegment = list.map((e) => e['name']).first;
      return nameSegment;
    } catch (e) {
      Get.printError(info: "$e");
      return nameSegment = '';
    }
  }
}
