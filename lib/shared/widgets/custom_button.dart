import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/text_styles.dart';
import '../styles/widget_styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.height = 50,
      this.primaryColor = true,
      this.width = 100,
      this.backgroundColor,
      this.leftIcon,
      this.blockDoubleClick = true,
      this.rightIcon})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final bool primaryColor;
  final bool? blockDoubleClick;
  final Color? backgroundColor;
  final AssetImage? leftIcon;
  final AssetImage? rightIcon;

  final RxBool absorbPointer = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx((() => AbsorbPointer(
          absorbing: absorbPointer.value,
          child: (ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: backgroundColor,
              minimumSize: Size(0, height),
              elevation: WidgetStyles.elevatedButtondElevation,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(WidgetStyles.elevatedButtonRadius),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (leftIcon != null)
                  ImageIcon(
                    leftIcon,
                    color: Colors.white,
                  ),
                if (leftIcon != null || rightIcon != null) const Spacer(),
                Text(
                  text,
                  style: TextStyles.headlineStyle(
                      color: Colors.white, isBold: true),
                ),
                if (leftIcon != null || rightIcon != null) const Spacer(),
                if (rightIcon != null)
                  ImageIcon(
                    rightIcon,
                    color: Colors.white,
                  ),
              ],
            ),
            onPressed: () {
              if (blockDoubleClick!) {
                absorbPointer.value = true;
                onBlockBoubleCLick();
              }
              onPressed.call();
            },
          )),
        )));
  }

  onBlockBoubleCLick() {
    Future.delayed(const Duration(seconds: 2), () {
      absorbPointer.value = false;
    });
  }
}
