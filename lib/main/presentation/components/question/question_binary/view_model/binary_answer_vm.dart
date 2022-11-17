import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/binary_answer_item.dart';

class BinaryAnswerViewModel extends GetxController {
  RxList<String> options = <String>[].obs;
  RxInt group = (-1).obs;

  BinaryAnswerViewModel({
    required this.options,
  });

  RxList<Widget> radioGroup() {
    RxList<Widget> radioGroup = <Widget>[].obs;

    for (var i = 0; i < options.length; i++) {
      radioGroup.add(BinaryAnswerItem(title: options[i], position: i));
    }
    return radioGroup;
  }

  bool setToggleable(int idRadioButton) {
    if (group.value == idRadioButton) {
      return true;
    } else {
      return false;
    }
  }
}
