import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_navigation_bar.dart';

class CustomPage extends StatelessWidget {
  CustomPage({
    Key? key,
    required this.body,
    this.rightIconButtons = const <IconButton>[],
    this.backButton = false,
    this.title = '',
    this.subTitle = '',
    this.subTitle2 = '',
    this.icon = false,
    this.leftIconButtons = const <IconButton>[],
    this.bottomNavigationBar,
    this.onBackPressed,
    this.verticalPadding = 10.0,
    this.horizontalPadding = 20.0,
    this.floatingActionButtonAnimated,
  }) : super(key: key);

  final Widget body;
  final String title;
  final String subTitle;
  final String subTitle2;
  final bool backButton;
  final bool icon;
  final List<IconButton>? leftIconButtons;
  final List<IconButton>? rightIconButtons;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBackPressed;
  final AnimatedSlide? floatingActionButtonAnimated;

  double verticalPadding;
  double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Obx(
                () => CustomNavigationBar(
                  onBackPressed: onBackPressed,
                  title: title,
                  subTitle: subTitle,
                  subTitle2: subTitle2,
                  backButton: backButton,
                  icon: icon,
                  leftIconButtons: leftIconButtons,
                  rightIconButtons: rightIconButtons,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: verticalPadding),
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButtonAnimated,
    );
  }
}
