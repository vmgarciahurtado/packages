import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../lang/messages.dart';
import '../../../shared/colors/colors.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_page.dart';
import '../util/dynamic_form_globals.dart' as globals;
import '../view_model/dynamic_form_vm.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DynamicFormPage extends StatelessWidget {
  DynamicFormPage({Key? key}) : super(key: key);
  final DynamicFormViewModel viewModel = Get.find(tag: globals.getFormTag());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.isShowBackAlert.value = true;
        viewModel.onBackPressed();
        return false;
      },
      child: Obx(
        () => CustomPage(
          backButton: true,
          title: viewModel.titleForm.value,
          subTitle: viewModel.subTitleForm.value,
          onBackPressed: () {
            viewModel.isShowBackAlert.value = true;
            viewModel.onBackPressed();
          },
          rightIconButtons: [],
          body: SafeArea(
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: viewModel.listComponents.length > 1
                                      ? Column(
                                          children: viewModel.listComponents,
                                        )
                                      : viewModel.listComponents.isNotEmpty
                                          ? viewModel.listComponents[0]
                                          : Container())),
                          Visibility(
                            visible: viewModel.isStepProgress.value,
                            child: SizedBox(
                              height: Get.height * 0.05,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: StepProgressIndicator(
                                  size: 6,
                                  currentStep:
                                      viewModel.wizardComponentPosition.value,
                                  totalSteps: viewModel
                                          .dynamicFormContent.length
                                          .isLowerThan(1)
                                      ? 1
                                      : viewModel.dynamicFormContent.length,
                                  selectedColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: Get.height * 0.01),
                  Visibility(
                    visible: viewModel.isButtonRowVisible.value,
                    child: Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: Get.width * 0.4,
                                    child: Visibility(
                                      visible: viewModel.isCanceltButton.value,
                                      child: CustomButton(
                                          onPressed: () {
                                            viewModel.cancelForm();
                                          },
                                          text: Messages.appText.cancel),
                                    )),
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child: Visibility(
                                      visible: viewModel.isAcceptButton.value,
                                      child: CustomButton(
                                          onPressed: () {
                                            viewModel.saveForm();
                                          },
                                          text: Messages.appText.accept)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: Get.width * 0.4,
                                    child: Visibility(
                                      visible: viewModel.isPreviousButton.value,
                                      child: CustomButton(
                                          backgroundColor: Colores.primaryGray,
                                          onPressed: () {
                                            viewModel.goToPreviousQuestion();
                                          },
                                          text: Messages.appText.previous),
                                    )),
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child: Visibility(
                                      visible: viewModel.isNextButton.value,
                                      child: CustomButton(
                                          backgroundColor: Colores.primaryGray,
                                          onPressed: () {
                                            viewModel.goToNextQuestion();
                                          },
                                          text: Messages.appText.next)),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: viewModel.isDynamicFormAction.value,
                    child:
                        Expanded(flex: 1, child: viewModel.widgetAction!.value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
