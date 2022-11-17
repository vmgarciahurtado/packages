import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../view_model/dynamic_form_vm.dart';

class DynamicActionViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;

  DynamicActionViewModel({required this.dynamicFormContent});

  Future<Widget> action() async {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: Get.width * 0.4,
            child: CustomButton(
                onPressed: () {
                  doAction(dynamicFormContent.option![0].run!);
                },
                text: dynamicFormContent.option![0].name!)),
        SizedBox(
            width: Get.width * 0.4,
            child: CustomButton(
                onPressed: () {
                  doAction(dynamicFormContent.option![1].run!);
                },
                text: dynamicFormContent.option![1].name!)),
      ],
    );
  }

  void doAction(String s) {
    switch (s) {
      case 'CANCEL':
        var viewModel =
            Get.find<DynamicFormViewModel>(tag: globals.listTags.first);
        viewModel.functionWhenBackPressed = () {
          viewModel.deleteDataFromDB();
          Get.close(2);
        };
        viewModel.onBackPressed();
        break;
      case 'SAVE':
        var viewModel =
            Get.find<DynamicFormViewModel>(tag: globals.listTags.first);
        viewModel.functionWhenSave!.call();
        break;
    }
  }
}
