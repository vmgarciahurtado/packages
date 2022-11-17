import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

import '../../../../../../lang/messages.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/error_text_widget.dart';
import '../../../config/verify_answer_vm.dart';

class ViewRankingQuestionComponent extends StatelessWidget {
  final String title;
  final Widget rankingSlider;

  ViewRankingQuestionComponent({
    Key? key,
    required this.title,
    required this.rankingSlider,
  }) : super(key: key);

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.subHeadLineStyle(isBold: true, color: Colors.black),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        rankingSlider,
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() {
          return Visibility(
              visible: verifyViewModel.showError.value,
              //'La respuesta es requerida'
              child: ErrorText(text: Messages.appText.requiredAnswer));
        }),
      ],
    );
  }
}
