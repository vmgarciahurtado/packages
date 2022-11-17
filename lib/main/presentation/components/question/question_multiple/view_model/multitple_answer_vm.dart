import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../domain/model/answer_values_response.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../widgets/multiple_answer_item.dart';

class MultipleAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;

  RxList<String> options = <String>[].obs;
  RxBool response = false.obs;
  RxList<AnswerValuesResponse> values = RxList();

  MultipleAnswerViewModel(
      {required this.options, required this.dynamicFormContent});

  RxList<Widget> checkGroup() {
    RxList<Widget> radioGroup = <Widget>[].obs;

    for (var i = 0; i < options.length; i++) {
      radioGroup.add(MultipleAnswerItem(title: options[i], position: i));
    }
    return radioGroup;
  }
}
