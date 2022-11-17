import 'package:get/get.dart';
import '../../util/dynamic_form_globals.dart' as globals;
import '../../view_model/dynamic_form_vm.dart';

class VerifyAnswerViewModel extends GetxController {
  final DynamicFormViewModel viewModel = Get.find(tag: globals.getFormTag());

  RxBool isResponse = false.obs;
  RxBool showError = false.obs;
  RxBool isRequired = false.obs;
  RxInt answerPosition = 0.obs;
  RxString code = ''.obs;
  RxString answer = ''.obs;
  RxString defaultAnswer = ''.obs;

  String tag = globals.tag;
}
