import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../config/verify_answer_vm.dart';
import '../widgets/date_answer_item.dart';
import 'package:intl/intl.dart';

class DateAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  DateAnswerViewModel({required this.dynamicFormContent});

  String format = 'yyyy-MM-dd';

  Rx<TextEditingController> textController = TextEditingController().obs;

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget date() {
    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.format != null) {
      format = dynamicFormContent.config!.format!;
    }
    return DateAnswerItem(format: format);
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      firstDate: DateTime(1900, 1, 1),
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    if (selected != null) {
      String selectedDate = DateFormat(format).format(selected);
      answerIsResponse(selectedDate);
    } else {
      if (textController.value.text.isEmpty) {
        answerIsNotResponse();
      }
    }
  }

  void answerIsResponse(String date) {
    textController.value.text = date;
    verifyViewModel.answer.value = '{"value":"${textController.value.text}"}';
    verifyViewModel.isResponse.value = true;
    verifyViewModel.showError.value = false;
  }

  void answerIsNotResponse() {
    textController.value.clear();
    verifyViewModel.isResponse.value = false;
    verifyViewModel.showError.value = true;
  }
}
