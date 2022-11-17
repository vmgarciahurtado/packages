import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/error_text_widget.dart';
import '../../../config/verify_answer_vm.dart';

class ViewMultipleAnswerComponent extends StatelessWidget {
  final String title;
  final RxList<Widget> checkGroup;

  ViewMultipleAnswerComponent(
      {Key? key, required this.title, required this.checkGroup})
      : super(key: key);

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(children: [
            Text(
              title,
              style: TextStyles.subHeadLineStyle(
                  isBold: true, color: Colors.black),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Column(
              children: checkGroup,
            ),
            Obx(() {
              return Visibility(
                  visible: verifyViewModel.showError.value,
                  //'La respuesta es requerida'
                  child: ErrorText(text: Messages.appText.requiredAnswer));
            }),
          ]),
        ],
      ),
    ));
  }
}
