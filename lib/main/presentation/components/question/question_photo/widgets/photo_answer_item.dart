import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../lang/messages.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../view_model/photo_answer_vm.dart';

class PhotoAnswerItem extends StatelessWidget {
  PhotoAnswerItem({Key? key}) : super(key: key);

  final PhotoAnswerViewModel viewModel =
      Get.find(tag: '6218f580705d3658a21b2588');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints.tight(Size(Get.width * 0.9, Get.height * 0.22)),
          child: GestureDetector(
            child: CustomCard(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !viewModel.widgetVisibility.value,
                  child: Center(
                    child: Expanded(
                        child: Text(Messages.appText.addPhotoClick,
                            style: TextStyles.bodyStyle(
                                isBold: true, color: Colores.primaryColor),
                            textAlign: TextAlign.center)),
                  ),
                ),
                Visibility(
                  visible: viewModel.widgetVisibility.value,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: viewModel.listPhotos),
                ),
              ],
            )),
            onTap: () {
              //viewModel.openImagePicker(context);
            },
          ),
        ),
      );
    });
  }
}
