import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class TextBtn extends StatelessWidget {
  bool isSelected;
  String text;
  OnPressed onPressed;

  TextBtn({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: AppColors.transparent,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor)
            : BorderSide(width: 1, color: Theme.of(context).dividerColor),
      ),
      child: Text(
        text,
        style: isSelected
            ? AppStyles.simi14White
            : Theme.of(context).textTheme.bodyMedium,
      ).tr(),
    );
  }
}
