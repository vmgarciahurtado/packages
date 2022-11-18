import '../interface/i_nomenclature_address.dart';
import '../model/nomenclature_address.dart';

class NomenclatureAddressService {
  final INomenclatureAddressRepository iNomenclatureAddressRepository;
  NomenclatureAddressService({required this.iNomenclatureAddressRepository});

  Future<List<NomenclatureAddress>> getNomenclatureAddress() async {
    return await iNomenclatureAddressRepository.getNomenclatureAddress();
  }
}
