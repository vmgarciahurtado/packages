import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../assets/assets.dart';
import '../styles/text_styles.dart';
import '../styles/widget_styles.dart';

// ignore: must_be_immutable
class CustomNavigationBar extends StatefulWidget {
  final String title;
  final String subTitle;
  final String subTitle2;
  final bool backButton;
  final bool icon;
  final List<IconButton>? leftIconButtons;
  final List<IconButton>? rightIconButtons;
  final VoidCallback? onBackPressed;

  const CustomNavigationBar({
    Key? key,
    this.rightIconButtons,
    this.backButton = false,
    this.title = '',
    this.subTitle = '',
    this.subTitle2 = '',
    this.icon = false,
    this.leftIconButtons = const <IconButton>[],
    this.onBackPressed,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final headerHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: WidgetStyles.customNavigationBarElevation,
      child: Container(
        color: Colors.white,
        height: headerHeight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: widget.backButton,
                child: _backButton(context),
              ),
              _leftIcons(),
              _texts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
      onPressed: () {
        if (widget.onBackPressed == null) {
          Navigator.of(context).pop();
        } else {
          widget.onBackPressed!();
        }
      },
    );
  }

  Widget _leftIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: widget.leftIconButtons ?? [],
    );
  }

  Widget _texts() {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyles.subHeadLineStyle(isBold: true),
              ),
              Text(
                widget.subTitle,
                maxLines: 1,
                style: TextStyles.subHeadLineStyle(),
              ),
              widget.subTitle2 != ''
                  ? Text(
                      widget.subTitle2,
                      maxLines: 1,
                      style: TextStyles.caption3Style(),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
