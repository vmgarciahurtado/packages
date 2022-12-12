import 'dart:io';
import 'dart:ui' as ui;

import 'package:packages/shared/colors/colors.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/verify_answer_vm.dart';
import '../widgets/signing_answer_item.dart';

class SigningAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  SigningAnswerViewModel({required this.dynamicFormContent});
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  RxBool widgetVisibility = false.obs;
  RxInt flex1 = 20.obs;
  RxInt flex2 = 0.obs;
  Rx<Image> image = Image(image: AssetImage(Res.icons.addImageIcon)).obs;
  Rx<Widget> widget = Container().obs;

  RxBool isDrawSigning = false.obs;

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget signing() {
    return SigningAnswerItem();
  }

  void getWidget(BuildContext context) {
    Get.dialog(Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  child: SfSignaturePad(
                    key: signatureGlobalKey,
                    backgroundColor: Colors.white,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0,
                    onDraw: (offset, time) {
                      isDrawSigning.value = true;
                    },
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)))),
          const SizedBox(height: 10),
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  text: Messages.appText.clear,
                  backgroundColor: Colores.secondaryColor,
                  onPressed: () {
                    _handleClearButtonPressed();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  text: Messages.appText.save,
                  backgroundColor: Colores.primaryColor,
                  onPressed: () {
                    handleSaveButtonPressed(context);
                  },
                ),
              ),
            ),
          ], mainAxisAlignment: MainAxisAlignment.spaceAround)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center));
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
    isDrawSigning.value = false;
  }

  void handleSaveButtonPressed(BuildContext context) async {
    if (isDrawSigning.value) {
      isDrawSigning.value = false;

      flex1.value = 0;
      flex2.value = 20;

      final data =
          await signatureGlobalKey.currentState!.toImage(pixelRatio: 1.0);
      final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
      widgetVisibility.value = true;
      image.value = Image.memory(bytes!.buffer.asUint8List());

      String id = const Uuid().v4();
      var documentDirectory = await getApplicationDocumentsDirectory();
      var directoryPath = documentDirectory.path + "/formimages/";
      await Directory(directoryPath).create(recursive: true);

      File file = File(directoryPath + "$id.jpg");
      file.writeAsBytesSync(bytes.buffer.asUint8List());

      verifyViewModel.isResponse.value = true;
      verifyViewModel.showError.value = false;
      verifyViewModel.answer.value = '{"value":"${path.basename(file.path)}"}';
    } else {
      if (!widgetVisibility.value) {
        verifyViewModel.isResponse.value = false;
        verifyViewModel.showError.value = true;
      }
    }

    Get.back();
  }
}
