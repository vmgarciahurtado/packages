import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/util/util.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';
import '../widgets/location_answer_item.dart';
import 'package:geolocator/geolocator.dart';

class LocationAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  String locationString = '';
  RxString lat = ''.obs;
  RxString long = ''.obs;
  LocationAnswerViewModel({required this.dynamicFormContent});

  Rx<TextEditingController> textController = TextEditingController().obs;
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget location() {
    return LocationAnswerItem(
      format: 'lat: lng:',
    );
  }

  void getLocation(BuildContext context) async {
    Get.dialog(
        Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints.tight(Size(Get.width * 0.7, Get.height * 0.22)),
            child: CustomCard(
              body: Center(
                child: Text(
                  //'Capturando coordenadas...',
                  Messages.appText.capturingLocationCoordinates,
                  style: TextStyles.bodyStyle(
                      isBold: true, color: Colores.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    Position position = await Util.device.getCurrentLocation();
    lat.value = position.latitude.toString();
    long.value = position.longitude.toString();
    textController.value.text = "lat: ${lat.value} long: ${long.value}";
    Get.back();
    verifyViewModel.isResponse.value = true;
    verifyViewModel.showError.value = false;
    verifyViewModel.answer.value =
        '{"lat":"${lat.value}","lon":"${long.value}"}';
  }
}
