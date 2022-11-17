import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/colors/colors.dart';
import '../../../../../domain/model/dynamic_form_content.dart';

class GrouopQuestionViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  GrouopQuestionViewModel({required this.dynamicFormContent});

  Widget group() {
    return Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 25,
        child: Text(
          dynamicFormContent.label!,
          textAlign: TextAlign.center,
        ),
        color: Colores.secondaryGray);
  }
}
