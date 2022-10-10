import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_delete_form_answer.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class DynamicFormDeleteAnswerRepositorySqlite
    extends IDeleFormAnswerRepository {
  @override
  Future deleteAnswer(String context, String codClient) async {
    try {
      BaseSqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();
      String statement = '''DELETE FROM dynamic_answers
    WHERE dynamic_forms IN (
    SELECT dynamic_forms FROM dynamic_answers da
    INNER JOIN dynamic_forms df
    ON (da.dynamic_forms=df.code)
    WHERE da.client_id = '$codClient' AND df.context = '$context');''';
      await db.rawQuery(statement);

      String statement2 =
          ''' DELETE FROM  _local where context = 'dynamic_answers' and data like '%"client_id": "$codClient"%' ''';
      await db.rawQuery(statement2);
    } catch (e) {
      Get.printError(info: "$e");
    }
  }
}
