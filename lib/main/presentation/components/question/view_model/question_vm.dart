import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../shared/util/util.dart';
import '../../../../domain/model/dynamic_form_content.dart';
import '../../../util/dynamic_form_globals.dart' as globals;

import '../../../view_model/dynamic_form_vm.dart';
import '../question_address/view/view_address_question.dart';
import '../question_address/view_model/address_question_vm.dart';
import '../question_binary/view/view_binary_question.dart';
import '../question_binary/view_model/binary_answer_vm.dart';
import '../question_date/view/view_date_answer.dart';
import '../question_date/view_model/date_answer_vm.dart';
import '../question_date_time/view/view_datetime_answer.dart';
import '../question_date_time/view_model/date_time_answer_vm.dart';
import '../question_group_question/view_model/group_question_vm.dart';
import '../question_location/view/view_location_answer.dart';
import '../question_location/view_model/location_answer_vm.dart';
import '../question_matrix_check/view/view_matrix_check.dart';
import '../question_matrix_check/view_model/matrix_check_vm.dart';
import '../question_matrix_number/view/view_matrix_number.dart';
import '../question_matrix_number/view_model/matrix_number_vm.dart';
import '../question_multiple/view/view_multiple_answer.dart';
import '../question_multiple/view_model/multitple_answer_vm.dart';
import '../question_number/view/view_number_answer.dart';
import '../question_number/view_model/number_answer_vm.dart';
import '../question_photo/view/view_photo_answer.dart';
import '../question_photo/view_model/photo_answer_vm.dart';
import '../question_ranking/view/view_ranking_answer.dart';
import '../question_ranking/view_model/ranking_vm.dart';
import '../question_signing/view/view_signing_answer.dart';
import '../question_signing/view_model/signing_answer_vm.dart';
import '../question_text/view/view_text_answer.dart';
import '../question_text/view_model/text_answer_vm.dart';
import '../question_time/view/view_time_answer.dart';
import '../question_time/view_model/time_answer_vm.dart';
import '../question_unique_list/view/view_unique_list.dart';
import '../question_unique_list/view_model/unique_list_vm.dart';

import '../../config/verify_answer_vm.dart';
import '../question_only/view/view_only_answer.dart';
import '../question_only/view_model/only_answer_vm.dart';

class QuestionComponentViewModel extends GetxController {
  late DynamicFormContent dynamicFormContent;

  /// The above function is responsible for creating the components of the questions.
  ///
  /// Args:
  ///   dynamicFormContent (DynamicFormContent): This is the object that contains all the information
  /// about the question.
  ///
  /// Returns:
  ///   A Widget
  Future<Widget> create(DynamicFormContent dynamicFormContent) async {
    DynamicFormViewModel dynamicFormViewModel =
        Get.find(tag: globals.getFormTag());

    switch (dynamicFormContent.type) {
      case 'only_answer':
        globals.tag = dynamicFormContent.id!;

        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":"{"id":"","value":""}"}';

        var binaryAnswerViewModel = Get.put(
            OnlyAnswerViewModel(
                options: listLabels(dynamicFormContent),
                dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        RxList<Widget> list = binaryAnswerViewModel.radioGroup();

        return ViewOnlyAnswerComponent(
          title: dynamicFormContent.label!,
          radioGroup: list,
        );

      case 'ranking':
        globals.tag = dynamicFormContent.id!;

        var rankingAnswerViewModel = Get.put(
            RankingAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        Widget component = rankingAnswerViewModel.rankingSlider();

        return ViewRankingQuestionComponent(
            title: dynamicFormContent.label!, rankingSlider: component);

      case 'binary_answer':
        globals.tag = dynamicFormContent.id!;

        var binaryAnswerViewModel = Get.put(
            BinaryAnswerViewModel(options: listLabels(dynamicFormContent)),
            tag: dynamicFormContent.id);

        RxList<Widget> list = binaryAnswerViewModel.radioGroup();

        return ViewBinaryQuestionComponent(
          title: dynamicFormContent.label!,
          radioGroup: list,
        );

      case 'text':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        //*verify have default answerer
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.setDefaultValue != null) {
          dynamicFormContent.defaultAnswer =
              getDefaultAnswer(dynamicFormContent.config!.setDefaultValue!);
        }

        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var textAnswerViewModel = Get.put(
            TextAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = textAnswerViewModel.text();

        return ViewTextAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'number':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        //*verify have default answerer
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.setDefaultValue != null) {
          dynamicFormContent.defaultAnswer =
              getDefaultAnswer(dynamicFormContent.config!.setDefaultValue!);
        }
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var textAnswerViewModel = Get.put(
            NumberAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = textAnswerViewModel.number();

        return ViewNumberAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'multiple_answer':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":[]}';

        var multipleAnswerViewModel = Get.put(
            MultipleAnswerViewModel(
                options: listLabels(dynamicFormContent),
                dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        RxList<Widget> list = multipleAnswerViewModel.checkGroup();

        return ViewMultipleAnswerComponent(
          title: dynamicFormContent.label!,
          checkGroup: list,
        );

      case 'date':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var dateAnswerViewModel = Get.put(
            DateAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = dateAnswerViewModel.date();

        return ViewDateAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'time':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var timeAnswerViewModel = Get.put(
            TimeAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = timeAnswerViewModel.time();

        return ViewTimeAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'datetime':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var dateTimeAnswerViewModel = Get.put(
            DateTimeAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = dateTimeAnswerViewModel.dateTime();

        return ViewDateTimeAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'location':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"lat":"","lon":""}';

        var locationAnswerViewModel = Get.put(
            LocationAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = locationAnswerViewModel.location();

        return ViewLocationAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'signing':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }
        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var signingAnswerViewModel = Get.put(
            SigningAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = signingAnswerViewModel.signing();

        return ViewSigningAnswerComponent(
            component: component, title: dynamicFormContent.label!);

      case 'photo':
        globals.tag = dynamicFormContent.id!;

        // //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":[]}';

        Get.put(PhotoAnswerViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        return ViewPhotoAnswerComponent(title: dynamicFormContent.label!);

      case 'group_question':
        globals.tag = dynamicFormContent.id!;
        var groupViewModel = Get.put(
            GrouopQuestionViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);
        Widget component = groupViewModel.group();

        return component;

      case 'address':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);

        //*verify have default answerer
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.setDefaultValue != null) {
          dynamicFormContent.defaultAnswer =
              getDefaultAnswer(dynamicFormContent.config!.setDefaultValue!);
        }

        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":""}';

        var addressViewModel = Get.put(
            AddressQuestionViewModel(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = addressViewModel.adress();

        return ViewAddressComponent(
          component: component,
        );

      case 'unique_list':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":[]}';

        var uniqueListViewModel = Get.put(
            UniqueListViewModel(
                options: listLabels(dynamicFormContent),
                dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = uniqueListViewModel.uniqueList();

        return ViewUniqueListComponent(
          title: dynamicFormContent.label!,
          component: component,
        );

      case 'matrix_number':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":[]}';

        var matrixNumberViewModel = Get.put(
            MatrixNumberVm(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = matrixNumberViewModel.matrixNumber();

        return ViewMatrixNumberComponent(
          title: dynamicFormContent.label!,
          component: component,
        );

      case 'matrix_check':
        globals.tag = dynamicFormContent.id!;

        //*verify error
        dynamicFormViewModel.saveAnswerId(dynamicFormContent.id!);
        var verify =
            Get.put(VerifyAnswerViewModel(), tag: dynamicFormContent.id);
        verify.code.value = dynamicFormContent.code!;

        //* verify if question is required
        if (dynamicFormContent.config != null &&
            dynamicFormContent.config!.requesed != null) {
          verify.isRequired.value =
              Util.data.getBool(dynamicFormContent.config!.requesed!);
        }

        //* set default answer
        verify.defaultAnswer.value = '{"value":[]}';

        var matrixNumberViewModel = Get.put(
            MatrixCheckVm(dynamicFormContent: dynamicFormContent),
            tag: dynamicFormContent.id);

        Widget component = matrixNumberViewModel.matrixCheck();

        return ViewMatrixCheckComponent(
          title: dynamicFormContent.label!,
          component: component,
        );

      default:
        return Container();
    }
  }

  /// It takes a DynamicFormContent object and returns a list of labels from the DynamicFormContent object
  ///
  /// Args:
  ///   dynamicFormContent (DynamicFormContent): The object that contains the form content.
  ///
  /// Returns:
  ///   A list of labels from the dynamic form content.

  RxList<String> listLabels(DynamicFormContent dynamicFormContent) {
    RxList<String> listLabels = <String>[].obs;

    for (var i = 0; i < dynamicFormContent.option!.length; i++) {
      listLabels.add(dynamicFormContent.option![i].label!);
    }
    return listLabels;
  }

  /// It takes a string, splits it into a list, and then uses the first item in the list to determine
  /// which model to use, and then uses the rest of the list to find the value in the model
  ///
  /// Args:
  ///   defaultValue (String): The default value of the question.
  ///
  /// Returns:
  ///   The default answer for the question.
  String getDefaultAnswer(String defaultValue) {
    List<String> param = defaultValue.split('.');

    switch (param[0]) {
      case 'client':
        if (Get.isRegistered<RouteClientViewModel>()) {
          Map<String, dynamic> clientMap;
          RouteClientViewModel routeClientViewModel = Get.find();
          var json = jsonEncode(routeClientViewModel.client.toJson());
          clientMap = jsonDecode(json);

          return getDefaultAnswerValue('client', param, 0, clientMap);
        }
    }
    return '';
  }

  /// It takes a string, a list of strings, an integer, and a map. It returns a string
  ///
  /// Args:
  ///   from (String): The source of the data.
  ///   param (List<String>): The list of parameters that are passed to the function.
  ///   paramPosition (int): The position of the parameter in the list of parameters.
  ///   objectMap: The object that contains the data to be used to fill the answer.
  String getDefaultAnswerValue(
      String from, List<String> param, int paramPosition, objectMap) {
    switch (from) {
      case 'client':
        if (objectMap is Map && paramPosition < param.length) {
          var map = objectMap.entries
              .firstWhere((element) => element.key == param[paramPosition + 1])
              .value;
          return getDefaultAnswerValue(
              'client', param, (paramPosition + 1), map);
        } else {
          if (objectMap is List) {
            var value = param.last.split('\$');
            var item = value.last.split('/');
            var number = int.parse(item.first);
            return objectMap[number][item.last];
          }
          return objectMap;
        }
    }

    return '';
  }
}
