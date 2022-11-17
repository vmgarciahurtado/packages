library dynamic_form.globals;

import 'package:uuid/uuid.dart';

String tag = '';
List<String> listTags = [];

removeFormTag() {
  listTags.removeLast();
}

String createFormTag() {
  String id = const Uuid().v4();
  listTags.add(id);
  return listTags.last;
}

String createMainFormTag() {
  listTags.clear();
  String id = const Uuid().v4();
  listTags.add(id);
  return listTags.last;
}

String getFormTag() {
  if (listTags.isNotEmpty) {
    return listTags.last.toString();
  } else {
    return '';
  }
}

String createEspecificFormTag(String tag) {
  listTags.clear();
  listTags.add(tag);
  return listTags.last;
}

void resetTagList() {
  listTags.clear();
}
