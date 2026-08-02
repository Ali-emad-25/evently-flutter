import 'package:evently/utils/AppColors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Appcolors.bgLightColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Appcolors.whiteColor,
      showDragHandle: true,
      dragHandleColor: Appcolors.mainLightModeColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Appcolors.bgLightColor,
      selectedItemColor: Appcolors.mainLightModeColor,
      unselectedItemColor: Appcolors.disableColor,
      selectedLabelStyle: AppStyles.reg12,
      unselectedLabelStyle: AppStyles.reg12,
    ),
    cardColor: Appcolors.whiteColor,
    dividerColor: Appcolors.dividerLightColor,
    primaryColor: Appcolors.mainLightModeColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20Black,
      labelLarge: AppStyles.medium16Black,
      labelMedium: AppStyles.reg14DarkGray,
    ),
  );

  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Appcolors.bgDarkColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Appcolors.cardDarkColor,
      showDragHandle: true,
      dragHandleColor: Appcolors.mainDarkModeColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Appcolors.bgDarkColor,
      selectedItemColor: Appcolors.mainDarkModeColor,
      unselectedItemColor: Appcolors.disableColor,
      selectedLabelStyle: AppStyles.reg12,
      unselectedLabelStyle: AppStyles.reg12,
    ),
    cardColor: Appcolors.cardDarkColor,
    dividerColor: Appcolors.dividerDarkColor,
    primaryColor: Appcolors.mainDarkModeColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20White,
      labelLarge: AppStyles.medium16White,
      labelMedium: AppStyles.reg14Gray,
    ),
  );
}
