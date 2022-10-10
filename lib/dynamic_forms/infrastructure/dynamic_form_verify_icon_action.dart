import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_verify_icon_action.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class VerifyIconActionRepositorySqlite extends IVerifyIconActionRepository {
  @override
  Future<bool> verifyAction(String codClient, String dynamicForm) async {
    BaseSqliteService baseSqliteService = SqliteService();
    Database db = await baseSqliteService.openDB();

    try {
      String statement = '''SELECT COUNT(*) AS number FROM dynamic_answers
          WHERE client_id = '$codClient'
          AND dynamic_forms = '$dynamicForm' ''';
      List<Map> list = await db.rawQuery(statement);

      final total = int.parse(list.map((e) => e['number']).first.toString());
      if (total > 0) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }
}
