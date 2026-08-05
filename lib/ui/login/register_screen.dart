import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/login/widgets/google_btn.dart';
import 'package:evently/ui/login/widgets/text_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/ui/onboarding/widgets/logo_widget.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: LogoWidget(), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'register_title',
                style: Theme.of(context).textTheme.titleLarge,
              ).tr(),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 15,
                  children: [
                    TextFieldWidget(
                      hintText: 'name_hint',
                      prefixIcon: AppAssets.nameIcon,
                    ),
                    TextFieldWidget(
                      hintText: 'email_hint',
                      prefixIcon: AppAssets.emailIcon,
                      textInputType: TextInputType.emailAddress,
                    ),
                    TextFieldWidget(
                      hintText: 'password_hint',
                      prefixIcon: AppAssets.passwordIcon,
                      isPasswordField: true,
                    ),
                    TextFieldWidget(
                      hintText: 'confirm_password_hint',
                      prefixIcon: AppAssets.passwordIcon,
                      isPasswordField: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              MainBtn(text: 'sign_up', onPressed: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Text(
                    'already_account',
                    style: Theme.of(context).textTheme.labelMedium,
                  ).tr(),
                  TextButtonWidget(
                    text: 'login',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.loginRouteName,
                      );
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(
                      color: themeProvider.isDarkMode
                          ? AppColors.strokeDarkColor
                          : AppColors.strokeLightColor,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        'or',
                        style: Theme.of(context).textTheme.titleMedium,
                      ).tr(),
                    ),
                  ],
                ),
              ),
              GoogleBtn(text: 'signup_google'),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
