import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/date_time_answer_item.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class DateTimeAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  DateTimeAnswerViewModel({required this.dynamicFormContent});

  String formatDate = 'yyyy-MM-dd';
  String formatTime = 'HH:mm:ss';
  String format = 'yyyy-MM-dd';
  RxString hour = ''.obs;

  Rx<TextEditingController> textController = TextEditingController().obs;

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget dateTime() {
    format = dynamicFormContent.config!.format!;
    formatDate = dynamicFormContent.config!.format!.split(' ').first;
    formatTime = dynamicFormContent.config!.format!.split(' ').last;
    return DateTimeAnswerItem(format: format);
  }

  selectDate(BuildContext context) async {
    //DateTime dateNow = DateTime.now();

    final DateTime? selected = await showDatePicker(
      context: context,
      firstDate: DateTime(1900, 1, 1),
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    if (selected != null) {
      //String date = DateFormat(formatDate).format(dateNow);
      String selectedDate = DateFormat(formatDate).format(selected);
      selectTime(context, selectedDate);
      // if (date != selectedDate) {
    } else {
      if (textController.value.text.isEmpty) {
        answerIsNotResponse();
      }
    }
  }

  selectTime(BuildContext context, String selectedDate) {
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
                  hour.value = DateFormat(formatTime).format(time);
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
                          answerIsResponse('$selectedDate ${hour.value}');
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
