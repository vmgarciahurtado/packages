import '../../../../util/dynamic_form_globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../lang/messages.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/error_text_widget.dart';
import '../../../config/verify_answer_vm.dart';

class ViewMatrixNumberComponent extends StatelessWidget {
  ViewMatrixNumberComponent(
      {Key? key, required this.component, required this.title})
      : super(key: key);

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  final Widget component;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.subHeadLineStyle(isBold: true, color: Colors.black),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        component,
        Obx(() {
          return Visibility(
              visible: verifyViewModel.showError.value,
              //'La respuesta es requerida'
              child: ErrorText(text: Messages.appText.requiredAnswer));
        }),
        SizedBox(
          height: Get.height * 0.02,
        ),
      ],
    );
  }
}
