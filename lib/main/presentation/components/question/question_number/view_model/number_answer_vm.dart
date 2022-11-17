import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/util/util.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/number_answer_item.dart';

class NumberAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  NumberAnswerViewModel({required this.dynamicFormContent});

  RxInt min = 0.obs;
  RxInt max = 0.obs;
  String hint = '';

  Rx<TextEditingController> numberController = TextEditingController().obs;

  Widget number() {
    if (dynamicFormContent.defaultAnswer != null &&
        dynamicFormContent.defaultAnswer!.isNotEmpty) {
      VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);
      verifyViewModel.isResponse.value = true;
      verifyViewModel.answer.value =
          '{"value":"${dynamicFormContent.defaultAnswer}"}';
      numberController.value.text = dynamicFormContent.defaultAnswer!;
    }
    hint = dynamicFormContent.label!;
    min.value = Util.data.getInt(dynamicFormContent.config!.min!);
    max.value = Util.data.getInt(dynamicFormContent.config!.max!);

    return NumberAnswerItem(
      min: min.value,
      max: max.value,
      hint: hint,
    );
  }
}
