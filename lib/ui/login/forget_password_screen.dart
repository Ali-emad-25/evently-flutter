import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/onboarding/widgets/back_btn.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forget_screen_title'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leadingWidth: 65,
        leading: BackBtn(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 40,
          children: [
            SizedBox(height: 10),
            Image.asset(
              themeProvider.isDarkMode
                  ? AppAssets.forgetImageDark
                  : AppAssets.forgetImage,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            MainBtn(text: 'reset_password'.tr(), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
