import '../model/nomenclature_address.dart';

abstract class INomenclatureAddressRepository {
  Future<List<NomenclatureAddress>> getNomenclatureAddress();
}
