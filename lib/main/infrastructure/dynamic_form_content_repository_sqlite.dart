import 'dart:convert';

import 'package:get/get.dart';
import 'package:packages/main/domain/interface/i_dynamic_form_content_repository.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/model/component_config.dart';
import '../domain/model/component_option.dart';
import '../domain/model/dynamic_form_content.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class DynamicFormContentRepositorySqlite extends IDynamicFormContentRepository {
  @override
  Future<List<DynamicFormContent>> getDynamicFormContent(String idForm) async {
    List<DynamicFormContent> listDynamicFormContent = [];
    try {
      BaseSqliteService sqliteService = SqliteService();
      Database db = await sqliteService.openDB();

      String statement =
          "SELECT _id,code,config,component,type,label,option FROM dynamic_contents Where dynamic_forms = '$idForm'  ORDER BY _id ASC";

      List<Map> list = await db.rawQuery(statement);

      for (var item in list) {
        dynamic optionsJson;
        List<ComponentOption> options;

        optionsJson = jsonDecode(item['option']);
        options = List<ComponentOption>.from(
            optionsJson.map((e) => ComponentOption.fromJson(e)));

        var answerConfigJson = jsonDecode(item['config']);
        var answerConfig = ComponentConfig.fromJson(answerConfigJson);

        DynamicFormContent dynamicFormContent = DynamicFormContent(
            component: item['component'],
            code: item['code'],
            label: item['label'],
            id: item['_id'],
            option: options,
            type: item['type'],
            config: answerConfig);
        listDynamicFormContent.add(dynamicFormContent);
      }
      return listDynamicFormContent;
    } catch (e) {
      Get.printError(info: "$e");
      return [];
    }
  }
}
