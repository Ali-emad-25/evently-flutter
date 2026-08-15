import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/login/widgets/text_button_widget.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TileListChoiceWidget extends StatelessWidget {
  final String icon;
  final String text;
  final String choiceText;
  final VoidCallback onTap;

  const TileListChoiceWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.choiceText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.width * 0.02,
      children: [
        Image.asset(icon),
        Text(text.tr(), style: Theme.of(context).textTheme.labelLarge),
        Spacer(),
        TextButtonWidget(text: choiceText.tr(), onTap: onTap),
      ],
    );
  }
}
