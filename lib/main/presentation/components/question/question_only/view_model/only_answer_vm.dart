import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../domain/model/dynamic_form_content.dart';
import '../widgets/only_answer_item.dart';

class OnlyAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;

  RxList<String> options = <String>[].obs;
  RxInt group = (-1).obs;

  OnlyAnswerViewModel(
      {required this.options, required this.dynamicFormContent});

  RxList<Widget> radioGroup() {
    RxList<Widget> radioGroup = <Widget>[].obs;

    for (var i = 0; i < options.length; i++) {
      radioGroup.add(OnlyAnswerItem(title: options[i], position: i));
    }
    return radioGroup;
  }

  bool setToggleable(int idRadioButton) {
    if (group.value == idRadioButton) {
      return true;
    } else {
      return false;
    }
  }
}
