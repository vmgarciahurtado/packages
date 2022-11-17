import 'package:core_app/_fuerza_venta/presentation/dynamic_form/components/question/question_address/widgets/address_assistant_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_app/_fuerza_venta/domain/dynamic_form/model/dynamic_form_content.dart';
import 'package:core_app/_fuerza_venta/domain/new_client/model/nomenclature_address.dart';
import 'package:core_app/_fuerza_venta/domain/new_client/service/nomenclature_address_service.dart';
import 'package:core_app/_fuerza_venta/infrastructure/new_client/repository/new_client_nomenclature_address_repository_sqlite.dart';
import 'package:core_app/lang/messages.dart';
import 'package:core_app/shared/Styles/text_styles.dart';
import 'package:core_app/shared/Styles/widget_styles.dart';
import 'package:core_app/shared/assets/assets.dart';
import 'package:core_app/shared/colors/colors.dart';
import 'package:core_app/shared/widgets/custom_button.dart';
import 'package:core_app/shared/widgets/custom_card.dart';
import 'package:core_app/shared/widgets/separator.dart';
import 'package:core_app/_fuerza_venta/presentation/dynamic_form/components/config/verify_answer_vm.dart';

import 'package:core_app/_fuerza_venta/presentation/dynamic_form/util/dynamic_form_globals.dart'
    as globals;
import 'package:packages/main/presentation/components/question/question_address/widgets/address_assistant_item.dart';

import '../../../../../../lang/messages.dart';
import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../../../shared/widgets/separator.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../config/verify_answer_vm.dart';

class AddressQuestionViewModel extends GetxController {
  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  DynamicFormContent dynamicFormContent;

  AddressQuestionViewModel({required this.dynamicFormContent});
  //Nomenclature Address service
  final NomenclatureAddressService nomenclatureAddressService =
      NomenclatureAddressService(
          iNomenclatureAddressRepository:
              NomenclatureAddressRepositorySqlite());

  TextEditingController txtAddressController = TextEditingController();
  RxString txtAddressErrorController = ''.obs;
  TextEditingController txtAddressAssistantController = TextEditingController();

  //Nomenclature address list
  final RxList<NomenclatureAddress> listNomenclatureAddress =
      <NomenclatureAddress>[].obs;

  @override
  onInit() {
    _getNomenclatureAddress();
    super.onInit();
  }

  Widget adress() {
    String labelText = dynamicFormContent.label!;

    if (dynamicFormContent.defaultAnswer != null &&
        dynamicFormContent.defaultAnswer!.isNotEmpty) {
      VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);
      verifyViewModel.isResponse.value = true;
      verifyViewModel.answer.value =
          '{"value":"${dynamicFormContent.defaultAnswer}"}';
      txtAddressController.text = dynamicFormContent.defaultAnswer!;
    }
    return FittedBox(
      child: Row(
        children: [
          SizedBox(
              width: Get.width * 0.9,
              child: TextField(
                enabled: false,
                onChanged: ((value) {
                  verifyViewModel.answer.value =
                      '{"value":"${txtAddressController.value.text}"}';
                  verifyViewModel.isResponse.value =
                      txtAddressController.value.text.length > 1 ? true : false;
                  verifyViewModel.showError.value =
                      !verifyViewModel.isResponse.value;
                }),
                maxLength: 100,
                controller: txtAddressController,
                style: TextStyles.headlineStyle(color: Colors.grey.shade900),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(WidgetStyles.textFieldRadius),
                      borderSide: BorderSide(
                          color: verifyViewModel.showError.value
                              ? Colors.red.shade400
                              : Colors.grey.shade400,
                          width: 1.0)),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(WidgetStyles.textFieldRadius),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                      left: 20, right: 20, top: 7, bottom: 7),
                  labelText: labelText,
                  labelStyle: TextStyles.bodyStyle(color: Colors.grey.shade400),
                ),
              )),
          GestureDetector(
            onTap: () {
              openDialogAddressAssistant();
            },
            child: SizedBox(
              height: Get.height * 0.09,
              width: Get.width * 0.2,
              child: CustomCard(
                padding: const EdgeInsets.all(10.0),
                color: Colores.primaryColor,
                body: ImageIcon(
                  AssetImage(Res.icons.addressAssistantIcon),
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  openDialogAddressAssistant() {
    Get.dialog(Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tight(Size(Get.width * 0.8, Get.height * 0.8)),
        child: CustomCard(
            body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Separator(size: 2),
            Text(
              Messages.appText.addressAssistant,
              style: TextStyles.subTitleStyle(isBold: true),
            ),
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                maxLength: 100,
                controller: txtAddressAssistantController,
                style: TextStyles.headlineStyle(color: Colors.grey.shade900),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(WidgetStyles.textFieldRadius),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                      left: 20, right: 20, top: 7, bottom: 7),
                  labelText: dynamicFormContent.label,
                  labelStyle: TextStyles.bodyStyle(color: Colors.grey.shade400),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            SizedBox(
              height: Get.height * 0.5,
              child: SingleChildScrollView(
                child: Wrap(
                  children: listNomenclatureAddressItem(),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * 0.35,
                  child: CustomButton(
                    text: Messages.appText.cancel,
                    backgroundColor: Colores.secondaryGray,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: Get.width * 0.01),
                SizedBox(
                  width: Get.width * 0.35,
                  child: CustomButton(
                    text: Messages.appText.accept,
                    onPressed: () {
                      Get.back();
                      txtAddressController.value =
                          txtAddressAssistantController.value;

                      verifyViewModel.answer.value =
                          '{"value":"${txtAddressController.value.text}"}';
                      verifyViewModel.isResponse.value =
                          txtAddressController.value.text.length > 1
                              ? true
                              : false;
                      verifyViewModel.showError.value =
                          !verifyViewModel.isResponse.value;
                    },
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    ));
  }

  Future _getNomenclatureAddress() async {
    listNomenclatureAddress.value =
        await nomenclatureAddressService.getNomenclatureAddress();
  }

  List<Widget> listNomenclatureAddressItem() {
    RxBool stringItem = false.obs;
    List<Widget> list = [];
    for (var i = 0; i < listNomenclatureAddress.length; i++) {
      AddressItem item = AddressItem(
          text: stringItem.isFalse
              ? listNomenclatureAddress[i].name
              : listNomenclatureAddress[i].code,
          onTap: () {
            _insertText(listNomenclatureAddress[i].code);
          });
      list.add(item);
    }
    return list;
  }

  void _insertText(String inserted) {
    final text = txtAddressAssistantController.text;

    final selection = txtAddressAssistantController.selection;
    int start = selection.start < 0 && selection.end < 0 ? 0 : selection.start;
    int end = selection.start < 0 && selection.end < 0 ? 0 : selection.end;
    final newText = text.replaceRange(start, end, ' $inserted');

    txtAddressAssistantController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
          offset: selection.baseOffset < 0
              ? 0 + inserted.length
              : selection.baseOffset + inserted.length + 1),
    );
  }
}
