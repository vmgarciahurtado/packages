import 'package:get/get.dart';
import 'messages.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => allKeys();

  Map<String, Map<String, String>> allKeys() {
    Iterable<Map<String, String>> generalTranslations =
        Messages().keys.values.where((element) => element.isNotEmpty);

    Map<String, String> enMap = {};
    enMap.addAll(generalTranslations.first);

    Map<String, String> esMap = {};
    esMap.addAll(generalTranslations.last);

    var map = {'en': enMap, 'es': esMap};
    return map;
  }
}
