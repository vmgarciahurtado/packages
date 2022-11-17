import 'package:flutter/material.dart';

import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/styles/widget_styles.dart';

class UniqueListItem extends StatelessWidget {
  const UniqueListItem({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.primaryStyle = false,
    this.width = 300,
  }) : super(key: key);

  final List<String> items;
  final Object value;
  final Function(Object) onChanged;
  final bool primaryStyle;
  final double width;
  final panelBorderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: WidgetStyles.dropDownElevation.toDouble(),
      borderRadius: BorderRadius.circular(WidgetStyles.dropDownRadius),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WidgetStyles.dropDownRadius),
            color: primaryStyle
                ? Theme.of(context).colorScheme.primary
                : Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            elevation: WidgetStyles.dropDownElevation,
            iconDisabledColor: Colores.secondaryGray,
            iconEnabledColor: primaryStyle ? Colors.white : Colors.black,
            dropdownColor: primaryStyle
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            isExpanded: true,
            borderRadius: BorderRadius.circular(panelBorderRadius),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: TextStyles.headlineStyle(
                      color: primaryStyle ? Colors.white : Colors.black),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              onChanged(newValue ?? "");
            },
            value: value,
          ),
        ),
      ),
    );
  }
}
