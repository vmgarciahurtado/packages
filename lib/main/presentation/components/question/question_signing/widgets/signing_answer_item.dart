import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../view_model/signing_answer_vm.dart';

class SigningAnswerItem extends StatelessWidget {
  SigningAnswerItem({Key? key}) : super(key: key);

  final SigningAnswerViewModel viewModel = Get.find(tag: globals.tag);

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
                Expanded(
                  flex: viewModel.flex1.value,
                  child: Visibility(
                    visible: !viewModel.widgetVisibility.value,
                    child: Center(
                        child: Text(
                            // 'Click para agregar firma.',
                            Messages.appText.addSignature,
                            style: TextStyles.bodyStyle(
                                isBold: true, color: Colores.primaryColor),
                            textAlign: TextAlign.center)),
                  ),
                ),
                Expanded(
                  flex: viewModel.flex2.value,
                  child: Visibility(
                    visible: viewModel.widgetVisibility.value,
                    child: Center(
                      child: Container(
                          color: Colors.grey[300],
                          child: viewModel.image.value),
                    ),
                  ),
                ),
              ],
            )),
            onTap: () {
              viewModel.getWidget(context);
            },
          ),
        ),
      );
    });
  }
}
