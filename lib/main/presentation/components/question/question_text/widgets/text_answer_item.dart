import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../view_model/text_answer_vm.dart';

class TextAnswerItem extends StatelessWidget {
  final int min;
  final int max;
  final bool textOnly;
  final String hint;

  TextAnswerItem(
      {Key? key,
      required this.min,
      required this.max,
      required this.textOnly,
      required this.hint})
      : super(key: key);

  final TextAnswerViewModel viewModel = Get.find(tag: globals.tag);
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        onChanged: (value) {
          verifyViewModel.answer.value =
              '{"value":"${viewModel.textController.value.text}"}';
          verifyViewModel.isResponse.value =
              viewModel.textController.value.text.length > min ? true : false;
          verifyViewModel.showError.value = !verifyViewModel.isResponse.value;
        },
        maxLength: max,
        controller: viewModel.textController.value,
        style: TextStyles.bodyStyle(color: Colors.grey.shade900),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WidgetStyles.textFieldRadius),
              borderSide: BorderSide(
                  color: verifyViewModel.showError.value
                      ? Colors.red.shade400
                      : Colors.grey.shade400,
                  width: 1.0)),
          prefixIcon: const Icon(
            Icons.text_format,
            size: 3,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(WidgetStyles.textFieldRadius),
          ),
          hintText: hint,
          hintStyle: TextStyles.bodyStyle(color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );
    });
  }
}
