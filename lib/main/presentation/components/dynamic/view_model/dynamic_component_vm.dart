import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import '../../../../domain/model/dynamic_form_content.dart';
import '../../../util/dynamic_form_globals.dart' as globals;
import '../../../view_model/dynamic_form_vm.dart';
import '../../config/verify_answer_vm.dart';
import '../dynamic_action/view_model/dynamic_action_vm.dart';
import 'package:flutter_html/flutter_html.dart';

class DynamicComponentViewModel extends GetxController {
  late DynamicFormContent dynamicFormContent;

  Future<Widget> create(DynamicFormContent dynamicFormContent) async {
    switch (dynamicFormContent.type) {
      case 'html':
        globals.tag = dynamicFormContent.id!;
        Get.put(VerifyAnswerViewModel(),
            tag: dynamicFormContent.id, permanent: true);
        DynamicFormViewModel dynamicFormViewModel =
            Get.find(tag: globals.getFormTag());
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        return Html(data: dynamicFormContent.label);

      case 'action':
        globals.tag = dynamicFormContent.id!;

        var dynamicActionViewModel = Get.put(
            DynamicActionViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        return dynamicActionViewModel.action();

      default:
        return Container();
    }
  }

  RxList<String> listLabels(DynamicFormContent dynamicFormContent) {
    RxList<String> listLabels = <String>[].obs;

    for (var i = 0; i < dynamicFormContent.option!.length; i++) {
      listLabels.add(dynamicFormContent.option![i].label!);
    }
    return listLabels;
  }
}
