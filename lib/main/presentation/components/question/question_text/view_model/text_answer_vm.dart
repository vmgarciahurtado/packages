import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/util/util.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/text_answer_item.dart';

class TextAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  TextAnswerViewModel({required this.dynamicFormContent});

  RxInt min = 0.obs;
  RxInt max = 200.obs;
  RxBool textOnly = false.obs;
  String hint = '';

  Rx<TextEditingController> textController = TextEditingController().obs;

  Widget text() {
    if (dynamicFormContent.defaultAnswer != null &&
        dynamicFormContent.defaultAnswer!.isNotEmpty) {
      VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);
      verifyViewModel.isResponse.value = true;
      verifyViewModel.answer.value =
          '{"value":"${dynamicFormContent.defaultAnswer}"}';
      textController.value.text = dynamicFormContent.defaultAnswer!;
    }

    if (dynamicFormContent.label != null) {
      hint = dynamicFormContent.label!;
    }
    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.min != null) {
      min.value = Util.data.getInt(dynamicFormContent.config!.min!);
    }

    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.max != null) {
      max.value = Util.data.getInt(dynamicFormContent.config!.max!);
    }

    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.textOnly != null) {
      textOnly.value = Util.data.getBool(dynamicFormContent.config!.textOnly!);
    }

    return TextAnswerItem(
      min: min.value,
      max: max.value,
      textOnly: textOnly.value,
      hint: hint,
    );
  }
}
