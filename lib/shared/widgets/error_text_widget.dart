import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyles.captionStyle(color: Colors.red.shade300));
  }
}
