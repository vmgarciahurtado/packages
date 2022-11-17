import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/uuid.dart';
import '../../../../../domain/model/answer_values_response.dart';
import '../../../../../domain/model/component_option.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;
import '../../../config/verify_answer_vm.dart';

class MatrixNumberVm extends GetxController {
  DynamicFormContent dynamicFormContent;
  MatrixNumberVm({required this.dynamicFormContent});

  RxList<DataColumn> columns = RxList();
  RxList<DataRow> rows = RxList();
  DataTable? dataTable;
  Map<String, TextEditingController> controllers = {};
  RxList<RxList<AnswerValuesResponse>> arrayList = RxList();
  Map<String, String> rowsAnswers = {};

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);

  Widget matrixNumber() {
    if (dynamicFormContent.option == null ||
        dynamicFormContent.option![0].rows == null ||
        dynamicFormContent.option![0].columns == null) {
      return const Text(
        "El componente 'Matriz numerica' fue creado de manera incorrecta",
        maxLines: 3,
        style: TextStyle(color: Colors.red),
      );
    }
    for (var i = 0; i < dynamicFormContent.option![0].columns!.length; i++) {
      if (i == 0) {
        columns.add(DataColumn(label: Container()));
      }
      columns.add(DataColumn(
          label: Text(
        dynamicFormContent.option![0].columns![i].title!,
        maxLines: 2,
      )));
    }

    for (var i = 0; i < dynamicFormContent.option![0].rows!.length; i++) {
      rows.add(DataRow(
          cells: getCell(dynamicFormContent.option![0].rows![i],
              dynamicFormContent.option![0].columns!)));
    }

    dataTable = DataTable(
      columns: columns,
      rows: rows,
      columnSpacing: 20,
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return Colors.grey.shade300;
      }),
      border: TableBorder.all(width: 1, color: Colors.grey.shade300),
    );

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: dataTable);
  }

  List<DataCell> getCell(RowForm row, List<ColumnForm> columns) {
    List<DataCell> listCells = [];
    RxList<AnswerValuesResponse> listForRowResponse = RxList();
    arrayList.add(listForRowResponse);
    Map<String, String> rowAnswer = {};

    for (var i = 0; i < columns.length; i++) {
      TextEditingController controller = TextEditingController();
      String id = Uuid().generateV4();
      controllers[id] = controller;
      if (i == 0 && row.title != null) {
        listCells.add(DataCell(Text(
          row.title!,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )));
      }

      int position = 0;

      if (arrayList.isNotEmpty) {
        position = arrayList.length - 1;
      }

      String key = columns[i].title!;

      AnswerValuesResponse answerValue =
          AnswerValuesResponse(id: key, value: controller.text);
      arrayList[position].add(answerValue);

      rowAnswer[key] = "{'id': '$key','value':''}";
      rowsAnswers[row.title!] =
          '{"id": "${row.title}","value":"${rowAnswer.values.toList()}"}';

      listCells.add(DataCell(TextField(
        controller: controllers.entries
            .firstWhere((element) => element.key == id)
            .value,
        keyboardType: TextInputType.number,
        onChanged: ((value) {
          for (var i = 0; i < arrayList[position].length; i++) {
            rowAnswer[key] = "{'id': '$key','value':'$value'}";
          }

          rowsAnswers[row.title!] =
              '{"id": "${row.title}","value":"${rowAnswer.values.toList()}"}';

          if (value != '') {
            verifyViewModel.answer.value = "${rowsAnswers.values.toList()}";
            verifyViewModel.isResponse.value = true;
            verifyViewModel.showError.value = false;
          }

          if (verifyViewModel.isRequired.value) {
            if (rowAnswer.values.toList() == []) {
              verifyViewModel.isResponse.value = false;
              verifyViewModel.showError.value = true;
            }
          }
        }),
      )));
    }

    if (!verifyViewModel.isRequired.value) {
      verifyViewModel.answer.value = "${rowsAnswers.values.toList()}";
      verifyViewModel.isResponse.value = true;
      verifyViewModel.showError.value = false;
    }

    return listCells;
  }
}
