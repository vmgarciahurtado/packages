import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_dynamic_form_repository.dart';
import '../domain/model/dynamic_form.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class DynamicFormRepositorySqlite extends IDynamicFormRepository {
  @override
  Future<DynamicForm> getDynamicForm(String idForm) async {
    DynamicForm? dynamicForm;
    try {
      BaseSqliteService _baseSqliteService = SqliteService();
      Database db = await _baseSqliteService.openDB();
      String statement =
          "SELECT _id,code,name,type,conditioned,context FROM dynamic_forms WHERE code = '$idForm'";
      List<Map> list = await db.rawQuery(statement);

      for (var item in list) {
        dynamicForm = DynamicForm(
            id: item['_id'],
            code: item['code'],
            name: item['name'],
            type: item['type'],
            conditioned: item['conditioned'],
            context: item['context']);
      }
      return dynamicForm!;
    } catch (e) {
      Get.printError(info: "$e");
      return dynamicForm!;
    }
  }
}
