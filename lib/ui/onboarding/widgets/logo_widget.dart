import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Image.asset(
      themeProvider.isDarkMode ? AppAssets.logoDark : AppAssets.logoLight,
    );
  }
}
