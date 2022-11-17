import 'package:flutter/material.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_card.dart';

class AddressItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AddressItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: SizedBox(
          width: 94,
          child: CustomCard(
            color: Colores.secondaryGray,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: FittedBox(
                      child: Text(
                        text,
                        style: TextStyles.caption3Style(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
