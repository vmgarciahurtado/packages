import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/main/domain/service/segmentation_service.dart';
import 'package:packages/main/infrastructure/segmentation_repository_sqlite.dart';
import 'package:packages/main/presentation/view_model/create_form_components_vm.dart';

import '../../../lang/messages.dart';
import '../../../shared/colors/colors.dart';
import '../../../shared/colors/hex_color.dart';
import '../../../shared/styles/text_styles.dart';
import '../../../shared/util/util.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../../../shared/widgets/custom_loading.dart';
import '../../domain/model/component_config.dart';
import '../../domain/model/component_option.dart';
import '../../domain/model/dynamic_form.dart';
import '../../domain/model/dynamic_form_answer.dart';
import '../../domain/model/dynamic_form_content.dart';
import '../../domain/model/personalization.dart';
import '../../domain/model/segmentation.dart';
import '../../domain/service/delete_form_answers_service.dart';
import '../../domain/service/dynamic_form_answer_service.dart';
import '../../domain/service/dynamic_form_content_service.dart';
import '../../domain/service/dynamic_form_service.dart';
import '../../infrastructure/dynamic_form_answer_repository_sqlite.dart';
import '../../infrastructure/dynamic_form_content_repository_sqlite.dart';
import '../../infrastructure/dynamic_form_delete_answer_repository_sqlite.dart';
import '../../infrastructure/dynamic_form_repository_sqlite.dart';
import '../components/config/verify_answer_vm.dart';

class DynamicFormViewModel extends GetxController {
  RxBool isNextButton = false.obs;
  RxBool isPreviousButton = false.obs;
  RxBool isCanceltButton = false.obs;
  RxBool isAcceptButton = false.obs;
  RxBool isStepProgress = false.obs;
  RxBool isCompleteForm = false.obs;
  RxBool isButtonRowVisible = false.obs;
  RxBool isSomeQuestionResponse = false.obs;

  RxBool isShowBackAlert = false.obs;

  RxBool isDynamicFormAction = false.obs;

  RxString titleForm = ''.obs;
  RxString subTitleForm = ''.obs;

  RxInt wizardComponentPosition = 1.obs;

  String? codClient = '';
  String nameClient = '';
  Map<String, dynamic>? clientMap;

  String idForm;
  String? header = '';
  String? context;

  bool canLoadServices;
  bool saveAnswers;
  bool returnAnswers;
  bool? callFromRouteClient;
  bool? callFromNewCLient;
  bool? saveHeader;

  VoidCallback? functionWhenFinish;
  VoidCallback? functionWhenBackPressed;
  VoidCallback? functionWhenStart = (() {});
  VoidCallback? functionWhenSave = (() {});
  VoidCallback? functionWhenCancel = (() {});

  String? requesedCondition = '';

  String codeParamSegmentation = '';
  String typeSurveySegmentation = '';
  double weightingSegmentation = 0;
  List<double> listeWeightingSegmentation = [];

  Rx<Widget>? widgetAction = Row().obs;

  Personalization? personalization;

  Segmentation segmentation = Segmentation();

  DynamicFormAnswer? defaultAnswer;
  DynamicFormViewModel(
      {required this.idForm,
      this.context,
      this.returnAnswers = false,
      this.saveAnswers = true,
      this.functionWhenFinish,
      this.functionWhenBackPressed,
      this.functionWhenStart,
      this.requesedCondition,
      this.functionWhenSave,
      this.functionWhenCancel,
      this.callFromRouteClient,
      this.codClient,
      this.callFromNewCLient,
      this.saveHeader = false,
      this.canLoadServices = true,
      this.header,
      this.personalization});

  final DynamicFormService _dynamicFormService =
      DynamicFormService(iDynamicFormRepository: DynamicFormRepositorySqlite());

  final DynamicFormContentService _dynamicFormContentService =
      DynamicFormContentService(
          iDynamicFormContentRepository: DynamicFormContentRepositorySqlite());

  final DynamicFormAnswerService _dynamicFormAnswerService =
      DynamicFormAnswerService(
          iDynamicFormAnswerRepository: DynamicFormAnswerRepositorySqlite());

  final DynamicFormDeleteAnswerService _dynamicFormDeleteAnswerService =
      DynamicFormDeleteAnswerService(
          iDeleFormAnswerRepository: DynamicFormDeleteAnswerRepositorySqlite());

  final SegmentationService _segmentationService = SegmentationService(
      iSegmentationRepository: SegmentationRepositorySqlite());

  DynamicForm dynamicForm = DynamicForm(
      code: "", id: "", name: "", type: "", conditioned: "", context: "");

  RxList<DynamicFormContent> dynamicFormContent = RxList();
  RxList<Widget> listComponents = RxList();
  RxList<Widget> listWizardComponents = RxList();
  RxList<ComponentConfig> listAnswerConfig = RxList();
  RxList<List<ComponentOption>> listAnswerOption = RxList();
  RxList<String> listAnswerId = RxList();
  RxList<DynamicFormAnswer> listCompletedAnswers = RxList();
  RxList<int> listIndexComponents = RxList();
  RxList<String> listVerifyAnswerId = RxList();

  List<String> orderedListComponent = [];
  List<String> groupChildren = [];

  @override
  void onInit() async {
    verifyPersonalization();
    getDynamicForm();
    getDynamicFormCotent();
    super.onInit();
  }

  verifyPersonalization() {
    if (personalization != null) {
      if (personalization!.primaryColor.contains("#")) {
        Colores.primaryColor = HexColor(personalization!.primaryColor);
      }
      if (personalization!.seCondaryColor.contains("#")) {
        Colores.secondaryColor = HexColor(personalization!.seCondaryColor);
      }
      if (personalization!.formBackground.contains("#")) {
        Colores.formBackground = HexColor(personalization!.formBackground);
      }
    }
  }

  /// It gets the form from the DB and sets the title and subtitle of the form.
  void getDynamicForm() async {
    dynamicForm = await _dynamicFormService.getDynamicForm(idForm);
    titleForm.value = dynamicForm.name;
  }

  /// The above function is used to get the content of the form from the DB.
  void getDynamicFormCotent() async {
    dynamicFormContent.value =
        await _dynamicFormContentService.getDynamicFormContent(idForm);
    createDynamicForm();
  }

  /// It creates the form components based on the type of form
  void createDynamicForm() async {
    switch (dynamicForm.type) {

      //*se visualizan las preguntas una a una
      case 'wizard':
        isNextButton.value = true;
        isStepProgress.value = true;
        isButtonRowVisible.value = true;

        for (var i = 0; i < dynamicFormContent.length; i++) {
          listWizardComponents.add(await CreateFormComponentViewModel()
              .create(dynamicFormContent[i]));
          listAnswerConfig.add(dynamicFormContent[i].config!);
          listAnswerOption.add(dynamicFormContent[i].option!);
        }

        listComponents.add(Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            body: listWizardComponents[0],
          ),
        ));

        listIndexComponents.add(0);

        break;

      //*se visualizan las preguntas en forma de lista
      case 'form':
        isCanceltButton.value = true;
        isAcceptButton.value = true;
        isButtonRowVisible.value = true;

        bool groupQuestion =
            dynamicFormContent.any((item) => item.type == 'group_question');

        if (groupQuestion) {
          await orderListAsGroupQuestion(dynamicFormContent);
        } else {
          for (var i = 0; i < dynamicFormContent.length; i++) {
            Widget component = await CreateFormComponentViewModel()
                .create(dynamicFormContent[i]);
            listComponents.add(Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: CustomCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                body: component,
              ),
            ));
            listAnswerConfig.add(dynamicFormContent[i].config!);
            listAnswerOption.add(dynamicFormContent[i].option!);
          }
        }

        break;

      //*se visualizan las preguntas en forma de lista
      //*No tiene botones de navegacion ni de confirmacion
      case 'dynamic':
        isButtonRowVisible.value = false;

        for (var i = 0; i < dynamicFormContent.length; i++) {
          Widget widget = await CreateFormComponentViewModel()
              .create(dynamicFormContent[i]);
          if (dynamicFormContent[i].type == 'action') {
            widgetAction!.value = widget;
            isDynamicFormAction.value = true;
          } else {
            listComponents.add(widget);
            listAnswerConfig.add(dynamicFormContent[i].config!);
            listAnswerOption.add(dynamicFormContent[i].option!);
          }
        }
        break;
    }
  }

  /// A function that is called when the user clicks on the next button.
  void goToNextQuestion() async {
    VerifyAnswerViewModel verifyViewModel =
        Get.find(tag: listAnswerId[listIndexComponents.last]);

    if (await verifyAnswer(listIndexComponents.last, verifyViewModel)) {
      wizardComponentPosition.value = listIndexComponents.last;
      _setButtonWizardFormVisivility();
      listComponents.removeAt((0));

      var widget = CustomCard(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        body: listWizardComponents[(listIndexComponents.last)],
      );
      listComponents.add(widget);
    }
  }

  /// It removes the last component from the list of components, removes the last index from the list of
  /// indexes, updates the wizardComponentPosition value, and adds the component corresponding to the new
  /// last index to the list of components
  void goToPreviousQuestion() {
    if (weightingSegmentation > 0) {
      weightingSegmentation =
          weightingSegmentation - listeWeightingSegmentation.last;
      listeWeightingSegmentation.removeLast();
    }

    listCompletedAnswers.removeLast();
    _setButtonWizardFormVisivility();
    if (listIndexComponents.length == 2) {
      isPreviousButton.value = false;
    }
    if (listIndexComponents.last != 0) {
      listComponents.removeAt((0));
      listIndexComponents.removeLast();
      wizardComponentPosition.value = listIndexComponents.last;

      var widget = CustomCard(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        body: listWizardComponents[(listIndexComponents.last)],
      );
      listComponents.add(widget);
    }
  }

  /// It sets the visibility of the buttons in the wizard form.
  void _setButtonWizardFormVisivility() {
    if (listIndexComponents.length - 1 >= 1) {
      isPreviousButton.value = true;
    } else {
      isPreviousButton.value = false;
    }

    if (listIndexComponents.last + 1 > dynamicFormContent.length) {
      isNextButton.value = false;
      isAcceptButton.value = true;
    } else {
      isNextButton.value = true;
      isAcceptButton.value = false;
    }
  }

  /// It verifies the answer and saves it.
  ///
  /// Args:
  ///   position (int): The position of the answer in the list of answers.
  ///   verifyViewModel (VerifyAnswerViewModel): is the object that contains the data of the question and
  /// the answer.
  ///
  /// Returns:
  ///   A boolean value.
  Future<bool> verifyAnswer(
      int position, VerifyAnswerViewModel verifyViewModel) async {
    if (isRequiredAnswer(position, verifyViewModel)) {
      if (dynamicForm.type != 'form' && dynamicForm.type != 'dynamic') {
        await saveAnswer(position, verifyViewModel);
        saveVerifyAnswer(listAnswerId[position]);

        if (answerHaveDestiny(position, verifyViewModel)) {
          return false;
        } else {
          return true;
        }
      } else {
        saveVerifyAnswer(listAnswerId[position]);
        return true;
      }
    } else {
      return false;
    }
  }

  /// It checks if the answer is required or not.
  ///
  /// Args:
  ///   position (int): The position of the answer in the list.
  ///   verifyViewModel (VerifyAnswerViewModel): is the view model that contains the data of the question
  /// and the answer.
  ///
  /// Returns:
  ///   A boolean value.
  bool isRequiredAnswer(int position, VerifyAnswerViewModel verifyViewModel) {
    if (listAnswerConfig[position].requesed == 'true') {
      if (verifyViewModel.isResponse.isTrue) {
        return true;
      } else {
        verifyViewModel.showError.value = true;
        return false;
      }
    } else {
      verifyViewModel.isResponse.value = true;
      saveVerifyAnswer(listAnswerId[position]);
      return true;
    }
  }

  /// A function that is used to verify if the answer has a destiny, if it has a destiny it will go to the
  /// destiny question, if it does not have a destiny it will return false.
  ///
  /// Args:
  ///   position (int): The position of the question in the list of questions.
  ///   verifyViewModel (VerifyAnswerViewModel): is the model that contains the answer and the position of
  /// the answer
  ///
  /// Returns:
  ///   a boolean value.
  bool answerHaveDestiny(int position, VerifyAnswerViewModel verifyViewModel) {
    if (listAnswerConfig[position].weighting != null) {
      var weighting = listAnswerConfig[position].weighting!.weighting!;

      if (typeSurveySegmentation == 'TD') {
        if (listAnswerConfig[position].questionScore != null) {
          if (Util.data.getBool(listAnswerConfig[position].questionScore!)) {
            int value = listAnswerOption[position]
                    [verifyViewModel.answerPosition.value]
                .value!;

            weightingSegmentation = weightingSegmentation + (weighting * value);
            listeWeightingSegmentation.add((weighting * value).toDouble());
          }
        } else {
          var answerValue = jsonDecode(verifyViewModel.answer.value);
          weightingSegmentation = weightingSegmentation +
              (weighting * double.parse(answerValue['value']));

          listeWeightingSegmentation
              .add(weighting * double.parse(answerValue['value']));
        }
      } else if (typeSurveySegmentation == 'AU') {
        if (listAnswerConfig[position].questionScore != null) {
          if (Util.data.getBool(listAnswerConfig[position].questionScore!)) {
            int value = listAnswerOption[position]
                    [verifyViewModel.answerPosition.value]
                .value!;

            weightingSegmentation =
                weightingSegmentation + (weighting * value) / 3;

            listeWeightingSegmentation.add((weighting * value) / 3);
          }
        } else {
          var answerValue = jsonDecode(verifyViewModel.answer.value);
          weightingSegmentation = weightingSegmentation +
              (weighting * double.parse(answerValue['value'])) / 3;

          listeWeightingSegmentation
              .add((weighting * double.parse(answerValue['value'])) / 3);
        }
      }
    }

    if (listAnswerOption[position][verifyViewModel.answerPosition.value]
        .destiny!
        .isEmpty) {
      return false;
    } else {
      goToAnswerDestiny(position, verifyViewModel);
      return false;
    }
  }

  /// A function that is responsible for moving to the next question, depending on the answer given by the
  /// user.
  ///
  /// Args:
  ///   position (int): is the position of the answer selected by the user
  ///   verifyViewModel (VerifyAnswerViewModel): is the view model that contains the answer position and
  /// the answer option list.
  goToAnswerDestiny(int position, VerifyAnswerViewModel verifyViewModel) async {
    String destiny = listAnswerOption[position]
            [verifyViewModel.answerPosition.value]
        .destiny!;

    //*posicion de la lista wizard donde esta el destino
    int index =
        dynamicFormContent.indexWhere(((element) => element.code == destiny));

    //*si el index es -1 quiere decir que en ese momento se acaba la encuesta
    if (index != -1) {
      //isCompleteForm.value = false;
      listIndexComponents.add(index);
      listIndexComponents.last = index;
      listComponents.removeAt((0));
      listComponents.add(listWizardComponents[(listIndexComponents.last)]);

      if (listAnswerConfig[listIndexComponents.last].weighting != null) {
        int codeParam = listAnswerOption[position]
                [verifyViewModel.answerPosition.value]
            .codeParam!;

        String typeSurvey =
            listAnswerConfig[listIndexComponents.last].weighting!.typeSurvey!;

        if (codeParamSegmentation == '' && typeSurveySegmentation == '') {
          codeParamSegmentation = codeParam.toString();
          typeSurveySegmentation = typeSurvey;
          listCompletedAnswers.last.isEndSegmentation = true;
        }
      }
    } else {
      //isCompleteForm.value = true;
      await saveAnswer(position, verifyViewModel);
      await sendAllAnswers();
    }
  }

  /// It adds the answerId to the listAnswerId.
  ///
  /// Args:
  ///   answerId (String): The answer ID of the answer that was upvoted.
  void saveAnswerId(String answerId) {
    listAnswerId.add(answerId);
  }

  /// This function saves the answer of the user in a list of answers
  ///
  /// Args:
  ///   position (int): is the position of the question in the list of questions
  ///   verifyViewModel (VerifyAnswerViewModel): is the view model that contains the answer to be saved
  saveAnswer(int position, VerifyAnswerViewModel verifyViewModel) async {
    String codeParam = '';
    String createdAt = Util.device.getCurrentDateTime();

    if (dynamicForm.type != 'form') {
      codeParam = listAnswerOption[position]
              [verifyViewModel.answerPosition.value]
          .codeParam
          .toString();
    }
    String answer = verifyViewModel.answer.value;
    if (answer.isEmpty) {
      answer = verifyViewModel.defaultAnswer.value;
    }
    String dynamicContentCode = verifyViewModel.code.value;

    DynamicFormAnswer dynamicFormAnswer = DynamicFormAnswer(
      dynamicForms: idForm,
      dynamicContents: dynamicContentCode,
      clientId: codClient,
      sellerId: codClient,
      answer: answer,
      createdAt: createdAt,
      codeParam: codeParam.isEmpty ? '' : codeParam,
    );

    //*agrega la respuesta a una lista de respuestas
    //*para recuperar estas en alguna otra clase
    listCompletedAnswers.add(dynamicFormAnswer);
  }

  /// It saves the id of the answer that the user has completed.
  ///
  /// Args:
  ///   idVerify (String): The ID of the verification question.
  saveVerifyAnswer(String idVerify) {
    if (!listVerifyAnswerId.contains(idVerify)) {
      listVerifyAnswerId.add(idVerify);
    }
  }

  /// It returns the list of completed answers.
  ///
  /// Returns:
  ///   A list of DynamicFormAnswer objects.
  List<DynamicFormAnswer> getListAnswers() {
    return listCompletedAnswers;
  }

  /// It shows a dialog with a question and two buttons.
  void cancelForm() {
    Get.dialog(
      CustomDialog(
        title: Text(
          Messages.appText.cancelSurvey,
          style: TextStyles.subTitle3Style(
            color: Colors.grey.shade800,
            isBold: true,
          ),
        ),
        hasRightButton: true,
        hasLeftButton: true,
        onRightPressed: () {
          Get.close(2);
        },
        onLeftPressed: () {
          Get.close(1);
        },
        content: Center(
          // '¿Seguro que quieres cancelar la encuesta?'
          child: Text(Messages.appText.wantCancelSurvey),
        ),
      ),
    );
  }

  /// The above function is used to save the form.
  void saveForm() async {
    int countRequiredResponse = 0;
    int requiredResponseComplete = 0;

    countRequiredResponse = 0;
    requiredResponseComplete = 0;

    for (var i = 0; i < listAnswerId.length; i++) {
      VerifyAnswerViewModel verifyViewModel = Get.find(tag: listAnswerId[i]);

      if (verifyViewModel.isResponse.value) {
        verifyViewModel.showError.value = false;
        if (verifyViewModel.isRequired.isTrue) {
          requiredResponseComplete = requiredResponseComplete + 1;
        }
      } else {
        if (verifyViewModel.isRequired.isTrue) {
          verifyViewModel.showError.value = true;
        }
      }

      if (verifyViewModel.isRequired.isTrue) {
        countRequiredResponse = countRequiredResponse + 1;
      }
    }

    if (requiredResponseComplete >= countRequiredResponse) {
      for (var i = 0; i < listAnswerId.length; i++) {
        VerifyAnswerViewModel verifyViewModel = Get.find(tag: listAnswerId[i]);
        await saveAnswer(i, verifyViewModel);
      }

      sendAllAnswers();
    } else {
      alertAnswerIsRequired();
    }
  }

  /// This function is responsible for sending the answers to the DB and showing a confirmation dialog
  Future<void> sendAllAnswers() async {
    isCompleteForm.value = true;
    saveFormAlert();
    if (saveAnswers) {
      if (await _dynamicFormAnswerService
          .setDynamicFormAnswer(listCompletedAnswers)) {
        confirmDialog();
      } else {
        Get.back();
        Get.snackbar(Messages.appText.error, Messages.appText.errorTryAgain,
            backgroundColor: Colors.red.shade400, colorText: Colors.white);
      }
    } else {
      confirmDialog();
    }
  }

  Future<void> calculateSegmentation() async {
    bool needCalculateSegment = false;

    String codeParam = listCompletedAnswers.last.codeParam!;

    for (var i = 0; i < listCompletedAnswers.length; i++) {
      if (listCompletedAnswers[i].isEndSegmentation != null) {
        if (listCompletedAnswers[i].isEndSegmentation!) {
          needCalculateSegment = true;
          codeParam = listCompletedAnswers[i].codeParam!;
        }
      }
    }

    try {
      segmentation = await _segmentationService.getSegmentation(codeParam);
    } catch (e) {
      segmentation = await _segmentationService.getSegmentation('0');
    }

    if (needCalculateSegment) {
      int weighting = weightingSegmentation.toInt();

      if (typeSurveySegmentation == 'TD') {
        weighting = weighting + 30;
      }
      segmentation.segmento = await _segmentationService.getSegment(
          typeSurveySegmentation, weighting);
    }

    await getNameSegment();
  }

  Future<void> getNameSegment() async {
    String tipologia = segmentation.tipologia!;
    segmentation.name = await _segmentationService.getNameSegment(tipologia);
  }

  /// It sends all the answers to the DB from another page
  /// only needs find this controller and call this method
  Future<void> sendAllAnswersFromHere() async {
    for (var i = 0; i < listCompletedAnswers.length; i++) {
      listCompletedAnswers[i].clientId = codClient;
    }
    await _dynamicFormAnswerService.setDynamicFormAnswer(listCompletedAnswers);
  }

  /// It displays a snackbar with a message qhen the for is type "form" to complete required answers.
  alertAnswerIsRequired() {
    Get.snackbar(Messages.appText.alert, Messages.appText.requiredSomeAnswer,
        backgroundColor: Colors.yellow.shade200);
  }

  /// It shows a dialog with a message.
  void saveFormAlert() {
    Get.dialog(Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tight(Size(Get.width * 0.7, Get.height * 0.22)),
        child: CustomCard(
          body: Center(
            child: Text(
              Messages.appText.recordingAnswers,
              style: TextStyles.bodyStyle(
                  isBold: true, color: Colores.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ));
  }

  /// A function that is called when the survey is completed.
  void confirmDialog() {
    Get.back();
    Get.dialog(
        CustomDialog(
          title: Text(Messages.appText.succesAction),
          hasRightButton: true,
          hasLeftButton: false,
          onRightPressed: () {
            if (functionWhenFinish != null) {
              functionWhenFinish!.call();
            }
            Get.close(2);
          },
          content: Center(
            child: Text(Messages.appText.succesRegistration),
          ),
        ),
        barrierDismissible: false);
  }

  /// A function that is called when the user clicks on the confirm button.
  void confirmDialogGeneral() async {
    CustomLoading(title: Messages.appText.loading);

    Future.delayed(const Duration(seconds: 2), (() {
      Get.back();
      Get.dialog(
          CustomDialog(
            title: Text(Messages.appText.succesAction),
            hasRightButton: true,
            hasLeftButton: false,
            onRightPressed: () {
              if (functionWhenFinish != null) {
                functionWhenFinish!.call();
              }
              Get.close(2);
            },
            content: Center(
              child: Text(Messages.appText.succesRegistration),
            ),
          ),
          barrierDismissible: false);
    }));
  }

  /// It clears the list of components, answer config and answer options.
  void updateScreen() {
    listComponents.clear();
    listAnswerConfig.clear();
    listAnswerOption.clear();
    onInit();
  }

  /// The above function is used to order the questions in the form.
  ///
  /// Args:
  ///   dynamicFormContent (RxList<DynamicFormContent>): The list of questions that you want to order.
  Future<void> orderListAsGroupQuestion(
      RxList<DynamicFormContent> dynamicFormContent) async {
    for (var i = 0; i < dynamicFormContent.length; i++) {
      if ((dynamicFormContent[i].config!.parent) != null) {
        groupChildren.add(dynamicFormContent[i].config!.parent!);
      }
    }

    await getChildren(0, 0);
  }

  /// The above function is a recursive function that takes in a parent position and a child position. It
  /// then checks if the last element in the groupChildren list is the same as the element at the parent
  /// position. If it is not, it checks if the element at the parent position contains a child at the
  /// child position. If it does, it calls itself again with the parent position and the child position
  /// incremented by one. If it does not, it adds the element at the parent position to the
  /// orderedListComponent list and calls itself again with the parent position incremented by one and the
  /// child position set to zero. If the last element in the groupChildren list is the same as the element
  /// at the parent position, it loops through the orderedListComponent list and calls the
  /// addGroupQuestion function with the element at the current index and the current index.
  ///
  /// Args:
  ///   parentPosition (int): The position of the parent in the list of groups.
  ///   childPosition (int): The position of the child in the list of children.
  ///
  /// Returns:
  ///   A list of questions that are in the order that they should be displayed.
  Future<void> getChildren(int parentPosition, int childPosition) async {
    if (!(groupChildren.last == groupChildren[parentPosition])) {
      if (containsChildren(groupChildren[parentPosition], childPosition)) {
        await getChildren(parentPosition, (childPosition + 1));
      } else {
        orderedListComponent.add(groupChildren[parentPosition]);
        return await getChildren((parentPosition + 1), 0);
      }
    } else {
      for (var i = 0; i < orderedListComponent.length; i++) {
        await addGroupQuestion(orderedListComponent[i], i);
      }
    }
  }

  /// > It checks if the parent has children and if it does, it adds the parent and the child to the
  /// ordered list
  ///
  /// Args:
  ///   groupParent (String): The parent of the group.
  ///   childPosition (int): The position of the child component in the group.
  ///
  /// Returns:
  ///   A boolean value.
  bool containsChildren(String groupParent, int childPosition) {
    var count = dynamicFormContent
        .where((c) => c.config!.parent == groupParent)
        .toList();

    if (!orderedListComponent.contains(groupParent)) {
      orderedListComponent.add(groupParent);
    }

    if (count.isNotEmpty) {
      if (count.length > childPosition) {
        orderedListComponent.add(count[childPosition].code!);
      } else {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  /// The above function adds a question to the form.
  ///
  /// Args:
  ///   code (String): The code of the question group
  ///   i (int): the index of the question in the list of questions

  Future<void> addGroupQuestion(String code, int i) async {
    if (dynamicFormContent.length > i) {
      listComponents.add(
          await CreateFormComponentViewModel().create(dynamicFormContent[i]));
      listAnswerConfig.add(dynamicFormContent[i].config!);
      listAnswerOption.add(dynamicFormContent[i].option!);
    }
  }

  /// A function that is called when the user presses the back button on the device.
  onBackPressed() {
    if (isShowBackAlert.value) {
      Get.dialog(
          CustomDialog(
            hasRightButton: true,
            hasLeftButton: true,
            hasLeftButtonText: "Cancelar",
            hasRightButtonText: "Completar",
            leftButtonColor: Colores.dangerColor,
            onLeftPressed: () async {
              if (functionWhenBackPressed != null) {
                functionWhenBackPressed!.call();
              } else {
                Get.close(2);
              }
            },
            onRightPressed: () async {
              Get.back();
            },
            title: Text(Messages.appText.alert),
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(Messages.appText.completeProcess),
              ),
            ),
          ),
          barrierDismissible: false);
    } else {
      Get.back();
    }
  }

  /// It deletes the data from the database
  Future<void> deleteDataFromDB() async {
    await _dynamicFormDeleteAnswerService.deleteFormAnswer(
        context!, codClient!);
  }

  /// It saves the header of the form.
  saveDynamicFormHeader() async {
    RxList<DynamicFormAnswer> answer = RxList();
    String createdAt = Util.device.getCurrentDateTime();

    DynamicFormAnswer dynamicFormAnswer = DynamicFormAnswer(
        dynamicForms: idForm,
        dynamicContents: '',
        clientId: codClient,
        sellerId: codClient,
        answer: header ?? '',
        createdAt: createdAt,
        codeParam: '');

    answer.add(dynamicFormAnswer);

    await _dynamicFormAnswerService.setDynamicFormAnswer(answer);
  }
}
