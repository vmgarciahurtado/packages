import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/time_answer_item.dart';

class TimeAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  TimeAnswerViewModel({required this.dynamicFormContent});

  String format = 'HH:mm:ss';
  RxString hour = ''.obs;

  Rx<TextEditingController> textController = TextEditingController().obs;

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget time() {
    format = dynamicFormContent.config!.format!;
    return TimeAnswerItem(format: format);
  }

  selectTime(BuildContext context) async {
    Get.dialog(Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tight(Size(Get.width * 0.7, Get.height * 0.40)),
        child: CustomCard(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle:
                    TextStyle(fontSize: 24, color: Colores.secondaryGray),
                highlightedTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.black),
                spacing: 30,
                itemHeight: 50,
                isForce2Digits: true,
                onTimeChange: (time) {
                  hour.value = DateFormat(format).format(time);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        if (textController.value.text.isEmpty) {
                          Get.back();
                          answerIsNotResponse();
                        } else {
                          Get.back();
                        }
                      },
                      child: Text(
                        Messages.appText.cancel,
                        style: TextStyles.subTitle3Style(),
                      )),
                  TextButton(
                      onPressed: () {
                        if (hour.value.isNotEmpty) {
                          Get.back();
                          answerIsResponse(hour.value);
                        } else {
                          Get.back();
                          answerIsNotResponse();
                        }
                      },
                      child: Text('ok', style: TextStyles.subTitle3Style()))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  void answerIsResponse(String date) {
    textController.value.text = date;
    verifyViewModel.answer.value = '{"value":"${textController.value.text}"}';
    verifyViewModel.isResponse.value = true;
    verifyViewModel.showError.value = false;
  }

  void answerIsNotResponse() {
    textController.value.clear();
    verifyViewModel.isResponse.value = false;
    verifyViewModel.showError.value = true;
  }
}
