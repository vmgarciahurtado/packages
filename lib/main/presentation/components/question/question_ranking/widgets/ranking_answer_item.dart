import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../view_model/ranking_vm.dart';

class ViewRankingAnswerItem extends StatelessWidget {
  final double interval;
  final double stepSize;
  final double min;
  final double max;

  ViewRankingAnswerItem({
    Key? key,
    required this.interval,
    required this.stepSize,
    required this.min,
    required this.max,
  }) : super(key: key);

  final RankingAnswerViewModel viewModel = Get.find(tag: globals.tag);
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SfSlider(
          value: viewModel.sliderValue.value,
          showLabels: true,
          enableTooltip: true,
          //tooltipShape: SfPaddleTooltipShape(),
          activeColor: Theme.of(context).colorScheme.primary,
          min: min,
          max: max,
          showTicks: true,
          minorTicksPerInterval: interval.toInt(),
          interval: interval,
          stepSize: stepSize,
          overlayShape: const SfOverlayShape(),
          onChanged: (value) {
            viewModel.sliderValue.value = value;
            if (value >= 0) {
              verifyViewModel.isResponse.value = true;
              verifyViewModel.showError.value = false;
              verifyViewModel.answerPosition.value = 0;
              verifyViewModel.answer.value = '{"value":"${value.toString()}"}';
            } else {
              verifyViewModel.isResponse.value = false;
            }
          });
    });
  }
}
