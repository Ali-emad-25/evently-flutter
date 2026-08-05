import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgLightColor,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.bgLightColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.whiteColor,
      showDragHandle: true,
      dragHandleColor: AppColors.mainLightModeColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgLightColor,
      selectedItemColor: AppColors.mainLightModeColor,
      unselectedItemColor: AppColors.disableColor,
      selectedLabelStyle: AppStyles.reg12,
      unselectedLabelStyle: AppStyles.reg12,
    ),
    cardColor: AppColors.whiteColor,
    dividerColor: AppColors.dividerLightColor,
    primaryColor: AppColors.mainLightModeColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20Black,
      headlineMedium: AppStyles.simi16MainLight,
      headlineSmall: AppStyles.medium14Black,
      labelLarge: AppStyles.medium16Black,
      labelMedium: AppStyles.reg14DarkGray,
      labelSmall: AppStyles.reg16DarkGray,
      bodyLarge: AppStyles.medium18MainLight,
      bodyMedium: AppStyles.simi14MainLight,
      titleLarge: AppStyles.simi24MainLight,
      titleMedium: AppStyles.medium16MainLight,
      titleSmall: AppStyles.simi14MainLight,
    ),
  );

  static final ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgDarkColor,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.bgDarkColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.cardDarkColor,
      showDragHandle: true,
      dragHandleColor: AppColors.mainDarkModeColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgDarkColor,
      selectedItemColor: AppColors.mainDarkModeColor,
      unselectedItemColor: AppColors.disableColor,
      selectedLabelStyle: AppStyles.reg12,
      unselectedLabelStyle: AppStyles.reg12,
    ),
    cardColor: AppColors.cardDarkColor,
    dividerColor: AppColors.dividerDarkColor,
    primaryColor: AppColors.mainDarkModeColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20White,
      headlineMedium: AppStyles.simi16MainDark,
      headlineSmall: AppStyles.medium14White,
      labelLarge: AppStyles.medium16White,
      labelMedium: AppStyles.reg14Gray,
      labelSmall: AppStyles.reg16Gray,
      bodyLarge: AppStyles.medium18White,
      bodyMedium: AppStyles.simi14White,
      titleLarge: AppStyles.simi24White,
      titleMedium: AppStyles.medium16MainDark,
      titleSmall: AppStyles.simi14MainDark,
    ),
  );
}
