import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnTap = void Function();

class BackBtn extends StatelessWidget {
  final OnTap onTap;

  const BackBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: context.height * 0.012,
          horizontal: context.width * 0.043,
        ),
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.021),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: themeProvider.isDarkMode
              ? AppColors.whiteColor
              : AppColors.mainLightModeColor,
        ),
      ),
    );
  }
}
