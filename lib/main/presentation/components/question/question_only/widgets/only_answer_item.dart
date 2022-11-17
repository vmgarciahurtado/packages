import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../view_model/only_answer_vm.dart';

class OnlyAnswerItem extends StatelessWidget {
  final String title;
  final int position;
  OnlyAnswerItem({Key? key, required this.title, required this.position})
      : super(key: key);

  final OnlyAnswerViewModel viewModel = Get.find(tag: globals.tag);
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
                return Radio(
                  value: position,
                  groupValue: viewModel.group.value,
                  onChanged: (value) {
                    viewModel.group.value = position;
                    verifyViewModel.isResponse.value = true;
                    verifyViewModel.showError.value = false;
                    verifyViewModel.answerPosition.value = position;

                    verifyViewModel.answer.value =
                        '{"value":"{"id":"${viewModel.dynamicFormContent.code}","value":"$title"}"}';
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                  toggleable: viewModel.setToggleable(position),
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
