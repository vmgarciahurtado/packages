import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/styles/text_styles.dart';

class ViewBinaryQuestionComponent extends StatelessWidget {
  final String title;
  final RxList<Widget> radioGroup;
  const ViewBinaryQuestionComponent(
      {Key? key, required this.title, required this.radioGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyles.subHeadLineStyle(
                      isBold: true, color: Colors.black),
                ),
              ),
              FittedBox(
                child: Expanded(
                    flex: 1,
                    child: Row(
                      children: radioGroup,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          )
        ],
      ),
    ));
  }
}
