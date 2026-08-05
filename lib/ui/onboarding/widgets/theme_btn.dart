import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnPressed = void Function();

class ThemeBtn extends StatelessWidget {
  bool isSelected;
  IconData selectedIcon;
  IconData unSelectedIcon;
  OnPressed onPressed;

  ThemeBtn({
    super.key,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

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
      child: Icon(
        isSelected ? selectedIcon : unSelectedIcon,
        color: isSelected
            ? AppColors.whiteColor
            : themeProvider.isDarkMode
            ? AppColors.whiteColor
            : AppColors.mainLightModeColor,
      ),
    );
  }
}
