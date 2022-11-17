import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

import '../../../../../../shared/styles/text_styles.dart';
import '../view_model/binary_answer_vm.dart';

class BinaryAnswerItem extends StatelessWidget {
  final String title;
  final int position;
  BinaryAnswerItem({Key? key, required this.title, required this.position})
      : super(key: key);

  final BinaryAnswerViewModel viewModel = Get.find(tag: globals.tag);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.subHeadLineStyle(isBold: true, color: Colors.black),
        ),
        Obx(() {
          return Radio(
            value: position,
            groupValue: viewModel.group.value,
            onChanged: (value) {
              viewModel.group.value = position;
            },
            activeColor: Theme.of(context).colorScheme.primary,
            toggleable: viewModel.setToggleable(position),
          );
        }),
      ],
    );
  }
}
