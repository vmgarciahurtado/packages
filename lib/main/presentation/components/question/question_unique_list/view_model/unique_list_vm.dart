import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../config/verify_answer_vm.dart';
import '../widgets/unique_list_item.dart';

class UniqueListViewModel extends GetxController {
  UniqueListViewModel(
      {required this.dynamicFormContent, required this.options});
  DynamicFormContent dynamicFormContent;
  RxList<String> options = <String>[].obs;
  RxString optionSelectecd = ''.obs;
  int defaultOption = 0;
  bool hasdefaultOption = false;

  Widget uniqueList() {
    VerifyAnswerViewModel verifyViewModel =
        Get.find(tag: dynamicFormContent.id);

    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.defaultValue != null) {
      defaultOption = dynamicFormContent.config!.defaultValue;
      hasdefaultOption = true;
      verifyViewModel.answer.value = '{"value":"${options[0]}"}';
    } else {
      verifyViewModel.answer.value = '{"value":"${options[defaultOption]}"}';
      verifyViewModel.isResponse.value = true;
    }

    optionSelectecd.value = options[defaultOption];

    return Obx(() => UniqueListItem(
          primaryStyle: true,
          items: options,
          value: optionSelectecd.value,
          onChanged: (value) {
            optionSelectecd.value = value.toString();
            verifyOptionSelected();
          },
        ));
  }

  void verifyOptionSelected() {
    VerifyAnswerViewModel verifyViewModel =
        Get.find(tag: dynamicFormContent.id);

    if (verifyViewModel.isRequired.value) {
      if (optionSelectecd.value != options[defaultOption]) {
        verifyViewModel.isResponse.value = true;
        verifyViewModel.answer.value = optionSelectecd.value;
        verifyViewModel.showError.value = false;
      } else {
        verifyViewModel.isResponse.value = false;
        verifyViewModel.showError.value = true;
        verifyViewModel.answer.value = optionSelectecd.value;
      }
    }
  }
}
