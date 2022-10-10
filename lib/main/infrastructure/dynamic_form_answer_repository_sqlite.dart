import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_dynamic_form_answer_repository.dart';
import '../domain/model/dynamic_form_answer.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class DynamicFormAnswerRepositorySqlite extends IDynamicFormAnswerRepository {
  @override
  Future<bool> setDynamicFormAnswer(
      List<DynamicFormAnswer> dynamicFormAnswer) async {
    try {
      BaseSqliteService baseSqliteService = SqliteService();
      Database db = await baseSqliteService.openDB();

      for (var i = 0; i < dynamicFormAnswer.length; i++) {
        String statement = "SELECT COUNT(*) AS total FROM dynamic_answers "
            "WHERE client_id = '${dynamicFormAnswer[i].clientId}' "
            "AND seller_id = '${dynamicFormAnswer[i].sellerId}' "
            "AND dynamic_contents = '${dynamicFormAnswer[i].dynamicContents}' "
            "AND dynamic_forms = '${dynamicFormAnswer[i].dynamicForms}' ";

        List<Map> list = await db.rawQuery(statement);

        double total =
            double.parse(list.map((e) => e['total']).first.toString());

        if (total <= 0) {
          await db.insert("dynamic_answers", dynamicFormAnswer[i].toJson());
        }
      }
      Get.printInfo(info: db.path);
      return true;
    } catch (e) {
      Get.printError(info: "$e");
      return false;
    }
  }
}
