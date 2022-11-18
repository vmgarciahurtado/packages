import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../domain/interface/i_nomenclature_address.dart';
import '../domain/model/nomenclature_address.dart';
import 'data/local/sqlite/base_sqlite_service.dart';
import 'data/local/sqlite/sqlite_service.dart';

class NomenclatureAddressRepositorySqlite
    extends INomenclatureAddressRepository {
  @override
  Future<List<NomenclatureAddress>> getNomenclatureAddress() async {
    List<NomenclatureAddress> listNomenclatureAddress = [];
    try {
      BaseSqliteService baseSqliteService = SqliteService();
      Database db = await baseSqliteService.openDB();
      String statement = "SELECT _id,code,name FROM nomeclature_address";
      List<Map> list = await db.rawQuery(statement);

      for (var item in list) {
        NomenclatureAddress nomenclatureAddress = NomenclatureAddress(
            id: item['_id'], name: item['name'], code: item['code']);
        listNomenclatureAddress.add(nomenclatureAddress);
      }

      return listNomenclatureAddress;
    } catch (e) {
      Get.printError(info: "$e");
      return [];
    }
  }
}
