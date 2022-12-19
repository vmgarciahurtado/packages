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
    try {
      BaseSqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();
      String statement = '''SELECT code_segment 
           FROM segment_classification 
           WHERE type = '$typeSurvey' AND $weighting >= _from  ORDER BY _from  DESC LIMIT 1 ''';
      List<Map> list = await db.rawQuery(statement);
      segment = list.map((e) => e['code_segment']).first;
      return segment;
    } catch (e) {
      Get.printError(info: "$e");
      return segment = '';
    }
  }

  @override
  Future<String> getNameSegment(String segment) async {
    String nameSegment = '';
    try {
      BaseSqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();
      String statement = '''SELECT name 
           FROM segment_description 
           WHERE code = '$segment' AND type = 'tipologia' ''';
      List<Map> list = await db.rawQuery(statement);
      segment = list.map((e) => e['name']).first;
      return nameSegment;
    } catch (e) {
      Get.printError(info: "$e");
      return nameSegment = '';
    }
  }
}
