import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/onboarding/widgets/logo_widget.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/ui/onboarding/widgets/text_btn.dart';
import 'package:evently/ui/onboarding/widgets/theme_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.height * 0.074,
        title: LogoWidget(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.043),
          child: Column(
            spacing: context.height * 0.012,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: context.height * 0.012,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        themeProvider.isDarkMode
                            ? AppAssets.startBgDark
                            : AppAssets.startBgLight,
                        width: double.infinity,
                      ),
                      Text(
                        'start_title',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ).tr(),
                      Text(
                        'start_description',
                        style: Theme.of(context).textTheme.labelSmall,
                      ).tr(),
                      SizedBox(height: context.height * 0.0062),
                      Row(
                        spacing: context.width * 0.03,
                        children: [
                          Text(
                            'language',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ).tr(),
                          Spacer(),
                          TextBtn(
                            text: 'english',
                            isSelected: context.locale.languageCode == 'en',
                            onPressed: () {
                              context.setLocale(Locale('en'));
                            },
                          ),
                          TextBtn(
                            text: 'arabic',
                            isSelected: context.locale.languageCode == 'ar',
                            onPressed: () => context.setLocale(Locale('ar')),
                          ),
                        ],
                      ),
                      Row(
                        spacing: context.width * 0.03,
                        children: [
                          Text(
                            'theme',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ).tr(),
                          Spacer(),
                          ThemeBtn(
                            selectedIcon: Icons.wb_sunny,
                            unSelectedIcon: Icons.wb_sunny_outlined,
                            isSelected: !(themeProvider.isDarkMode),
                            onPressed: () {
                              themeProvider.changeTheme(ThemeMode.light);
                            },
                          ),
                          ThemeBtn(
                            selectedIcon: Icons.dark_mode,
                            unSelectedIcon: Icons.dark_mode_outlined,
                            isSelected: themeProvider.isDarkMode,
                            onPressed: () {
                              themeProvider.changeTheme(ThemeMode.dark);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              MainBtn(
                text: 'start_btn',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.onboardingRouteName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
