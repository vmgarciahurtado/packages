import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:packages/shared/widgets/custom_button.dart';

import '../../lang/messages.dart';
import '../colors/colors.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key,
      this.hasLeftButton = true,
      this.hasRightButton = false,
      this.canPop = false,
      this.hasLeftButtonText = "",
      this.hasRightButtonText = "",
      this.onRightPressed,
      this.onLeftPressed,
      this.leftButtonColor,
      this.rightButtonColor,
      this.title,
      this.padding = 10.0,
      required this.content})
      : super(key: key);

  final bool hasLeftButton;
  final bool hasRightButton;
  final bool canPop;
  final Function()? onLeftPressed;
  final Function()? onRightPressed;
  final Widget? title;
  final Widget content;
  final double padding;
  final String hasLeftButtonText;
  final String hasRightButtonText;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return canPop;
      },
      child: BounceInDown(
        duration: const Duration(milliseconds: 500),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
          contentPadding: EdgeInsets.all(padding),
          title: Center(child: title),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
              Visibility(
                visible: hasRightButton || hasLeftButton,
                child: Row(
                  children: <Widget>[
                    Visibility(
                      visible: hasLeftButton,
                      child: Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: CustomButton(
                            text: hasLeftButtonText == ""
                                ? Messages.appText.cancel
                                : hasLeftButtonText,
                            onPressed: onLeftPressed ??
                                () => {Navigator.of(context).pop()},
                            backgroundColor:
                                leftButtonColor ?? Colores.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: hasRightButton,
                      child: Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: CustomButton(
                            text: hasRightButtonText == ""
                                ? Messages.appText.accept
                                : hasRightButtonText,
                            onPressed: onRightPressed ??
                                () => {Navigator.of(context).pop()},
                            backgroundColor:
                                rightButtonColor ?? Colores.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
