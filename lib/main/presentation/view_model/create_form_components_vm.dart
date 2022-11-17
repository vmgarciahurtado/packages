import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../domain/model/dynamic_form_content.dart';
import '../components/dynamic/view_model/dynamic_component_vm.dart';
import '../components/question/view_model/question_vm.dart';

class CreateFormComponentViewModel extends GetxController {
  /// > It creates a widget based on the component type
  ///
  /// Args:
  ///   dynamicFormContent (DynamicFormContent): This is the object that contains the data for the
  /// component.
  ///
  /// Returns:
  ///   A widget.
  Future<Widget> create(DynamicFormContent dynamicFormContent) async {
    switch (dynamicFormContent.component) {
      case 'question':
        return await QuestionComponentViewModel().create(dynamicFormContent);
      case 'dynamic':
        return await DynamicComponentViewModel().create(dynamicFormContent);
      default:
        return Container();
    }
  }
}
