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
          'select': 'Select',
          'capture': 'Capture',
          'add': 'Add',
          'previous': 'Previous',
          'next': 'Next',
          'alert': '¡Alert!',
          'required_answer': 'The answer is required',
          'address_assistant': 'Address Assistant',
          'capturing_location_coordinates': 'Capturing Coordinates...',
          'upload_images': 'Upload Images',
          'maximum_photos': 'The maximum number of photos is ',
          'minimum_photos': 'The minimum number of photos is ',
          'add_photo_click': 'Click to add photo.',
          'add_signature': 'Click to add signature.',
        },
        'es': {
          'later': 'Despues',
          'clear': 'Limpiar',
          'save': 'Guardar',
          'accept': 'Aceptar',
          'cancel': 'Cancelar',
          'loading': 'Cargando...',
          'select': 'Seleccionar',
          'capture': 'Capturar',
          'add': 'Añadir',
          'previous': 'Anterior',
          'next': 'Siguiente',
          'alert': '¡Alerta!',
          'required_answer': 'La respuesta es requerida',
          'address_assistant': 'Asistente de Direccion',
          'capturing_location_coordinates': 'Capturando Coordenadas...',
          'upload_images': 'Subir Imagenes',
          'maximum_photos': 'La cantidad maxima de fotos es ',
          'minimum_photos': 'La cantidad minima de fotos es ',
          'add_photo_click': 'Click para agregar foto.',
          'add_signature': 'Click para agregar firma.',
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
  final select = 'select'.tr;
  final capture = 'capture'.tr;
  final add = 'add'.tr;
  final previous = 'previous'.tr;
  final next = 'next'.tr;
  final alert = 'alert'.tr;

  final requiredAnswer = 'required_answer'.tr;
  final addressAssistant = 'address_assistant'.tr;
  final capturingLocationCoordinates = 'capturing_location_coordinates'.tr;

  final uploadImages = 'text_upload_images'.tr;
  final maximumPhotos = 'maximum_photos'.tr;
  final minimumPhotos = 'minimum_photos'.tr;
  final addPhotoClick = 'add_photo_click'.tr;
  final addSignature = 'add_signature'.tr;
}
