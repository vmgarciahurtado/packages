import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../view_model/number_answer_vm.dart';

class NumberAnswerItem extends StatelessWidget {
  final int min;
  final int max;
  final String hint;

  NumberAnswerItem(
      {Key? key, required this.min, required this.max, required this.hint})
      : super(key: key);

  final NumberAnswerViewModel viewModel = Get.find(tag: globals.tag);
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        onChanged: (value) {
          verifyViewModel.answer.value =
              '{"value":"${viewModel.numberController.value.text}"}';
          verifyViewModel.isResponse.value =
              viewModel.numberController.value.text.length > min ? true : false;
          verifyViewModel.showError.value = !verifyViewModel.isResponse.value;
        },
        maxLength: max,
        controller: viewModel.numberController.value,
        style: TextStyles.bodyStyle(color: Colors.grey.shade900),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.numbers),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(WidgetStyles.textFieldRadius),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(WidgetStyles.textFieldRadius),
              borderSide: BorderSide(
                  color: verifyViewModel.showError.value
                      ? Colors.red.shade400
                      : Colors.grey.shade400,
                  width: 1.0)),
          hintText: hint,
          hintStyle: TextStyles.bodyStyle(color: Colors.grey.shade400),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );
    });
  }
}
