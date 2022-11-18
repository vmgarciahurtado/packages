import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextStyles {
  static TextStyle largeStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 34,
    );
  }

  static TextStyle titleStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 30,
    );
  }

  static TextStyle title2Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 28,
    );
  }

  static TextStyle title3Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 26,
    );
  }

  static TextStyle subTitleStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 22,
    );
  }

  static TextStyle subTitle2Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 20,
    );
  }

  static TextStyle subTitle3Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 18,
    );
  }

  static TextStyle headlineStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 16,
    );
  }

  static TextStyle subHeadLineUnderLineStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      decoration: TextDecoration.underline,
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 14,
    );
  }

  static TextStyle subHeadLineStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 14,
    );
  }

  static TextStyle captionStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 12,
    );
  }

  static TextStyle caption2Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 11,
    );
  }

  static TextStyle caption3Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 10,
    );
  }

  static TextStyle caption4Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 8,
    );
  }

  static TextStyle caption5Style(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 6,
    );
  }

  static TextStyle bodyStyle(
      {Color color = Colors.black, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'OpenSans',
      fontSize: Get.textScaleFactor * 18,
    );
  }
}
