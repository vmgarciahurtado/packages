import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

class Messages extends Translations {
  static final appText = _AppText._();

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'later': 'Later',
          'clear': 'Clear',
          'save': 'Save',
          'botton': 'Accept',
          'cancel': 'Cancel',
          'loading': 'Loading...',
        },
        'es': {
          'later': 'Despues',
          'clear': 'Limpiar',
          'save': 'Guardar',
          'accept': 'Aceptar',
          'cancel': 'Cancelar',
          'loading': 'Cargando...',
        },
      };
}

class _AppText {
  _AppText._();

  final later = 'later'.tr;
  final clear = 'clear'.tr;
  final save = 'save'.tr;
  final accept = 'accept'.tr;
  final cancel = 'cancel'.tr;
  final loading = 'loading'.tr;
}
