import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/ranking_answer_item.dart';

class RankingAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  RankingAnswerViewModel({required this.dynamicFormContent});

  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  RxDouble interval = 0.0.obs;
  RxDouble stepSize = 0.0.obs;
  RxDouble sliderValue = 0.0.obs;

  Widget rankingSlider() {
    stepSize.value = 1;
    interval.value = double.parse(dynamicFormContent.config!.interval!);
    max.value = double.parse(dynamicFormContent.config!.max!);
    min.value = double.parse(dynamicFormContent.config!.min!);

    final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);
    verifyViewModel.isResponse.value = true;
    verifyViewModel.answerPosition.value = 0;
    verifyViewModel.answer.value = '{"value":"0"}';

    if (max.value <= 20) {
      interval.value = 1;
    } else if (max.value > 20 && max.value <= 50) {
      interval.value = 5;
    } else {
      double value = max.value * 0.1;
      interval.value = value;
    }

    return ViewRankingAnswerItem(
        interval: interval.value,
        stepSize: stepSize.value,
        min: min.value,
        max: max.value);
  }
}
