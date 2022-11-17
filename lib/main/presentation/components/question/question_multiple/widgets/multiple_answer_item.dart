import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../domain/model/answer_values_response.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

import '../../../config/verify_answer_vm.dart';
import '../view_model/multitple_answer_vm.dart';

class MultipleAnswerItem extends StatelessWidget {
  final String title;
  final int position;
  final RxBool response = false.obs;
  MultipleAnswerItem({Key? key, required this.title, required this.position})
      : super(key: key);

  final MultipleAnswerViewModel viewModel = Get.find(tag: globals.tag);
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Obx(() {
                return Checkbox(
                  value: response.value,
                  onChanged: (value) {
                    response.value = value!;
                    verifyViewModel.isResponse.value = response.value;
                    verifyViewModel.showError.value = false;
                    verifyViewModel.answerPosition.value = position;
                    if (response.value) {
                      AnswerValuesResponse value = AnswerValuesResponse(
                          id: viewModel.dynamicFormContent.code!, value: title);
                      viewModel.values.add(value);
                      verifyViewModel.answer.value =
                          '{"value":${jsonEncode(viewModel.values)}}';
                    } else {
                      viewModel.values
                          .removeWhere((element) => element.value == title);
                      verifyViewModel.answer.value =
                          '{"value":${jsonEncode(viewModel.values)}}';
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                );
              }),
            ),
            Expanded(
              flex: 9,
              child: Text(
                title,
                style: TextStyles.subHeadLineStyle(
                    isBold: true, color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}
