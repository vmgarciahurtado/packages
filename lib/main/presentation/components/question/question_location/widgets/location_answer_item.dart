import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';
import '../view_model/location_answer_vm.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

class LocationAnswerItem extends StatelessWidget {
  final String format;
  LocationAnswerItem({Key? key, required this.format}) : super(key: key);

  final LocationAnswerViewModel viewModel = Get.find(tag: globals.tag);

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
                viewModel.getLocation(context);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: ImageIcon(
                AssetImage(Res.icons.coordinateIcon),
                size: 30,
              ),
              onTap: () {
                viewModel.getLocation(context);
              },
            ),
          )
        ],
      );
    });
  }
}
