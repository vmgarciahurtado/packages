import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../view_model/date_time_answer_vm.dart';

class DateTimeAnswerItem extends StatelessWidget {
  final String format;
  DateTimeAnswerItem({Key? key, required this.format}) : super(key: key);

  final DateTimeAnswerViewModel viewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: GestureDetector(
              child: TextField(
                enabled: false,
                controller: viewModel.textController.value,
                style: TextStyles.bodyStyle(color: Colors.grey.shade900),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(WidgetStyles.textFieldRadius),
                  ),
                  hintText: format,
                  hintStyle: TextStyles.bodyStyle(color: Colors.grey.shade400),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                ),
              ),
              onTap: () {
                viewModel.selectDate(context);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: ImageIcon(
                AssetImage(Res.icons.calendarIcon),
                size: 30,
              ),
              onTap: () {
                viewModel.selectDate(context);
              },
            ),
          )
        ],
      );
    });
  }
}
