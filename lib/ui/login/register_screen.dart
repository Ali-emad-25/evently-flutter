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
import 'package:evently/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  RegisterScreen({super.key});

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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 15,
                  children: [
                    TextFieldWidget(
                      hintText: 'name_hint',
                      prefixIcon: AppAssets.nameIcon,
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter name.";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hintText: 'email_hint',
                      prefixIcon: AppAssets.emailIcon,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter email.";
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(emailController.text);
                        if (!emailValid) {
                          return "Please enter valid email".tr();
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hintText: 'password_hint',
                      prefixIcon: AppAssets.passwordIcon,
                      isPasswordField: true,
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter password.";
                        }
                        if (text.length < 6) {
                          return "Password must be at least 6 chars.";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hintText: 'confirm_password_hint',
                      prefixIcon: AppAssets.passwordIcon,
                      isPasswordField: true,
                      controller: rePasswordController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return "Please enter confirm password.";
                        }
                        if (text != rePasswordController.text) {
                          return "Confirm password doesn't match password.";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              MainBtn(text: 'sign_up', onPressed: () {
                register(context: context);
              },),
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

  void register({required BuildContext context}) async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, text: 'loading');
        await Future.delayed(Duration(seconds: 2));
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          content: 'added_successfully',
          title: 'sign_up',
          posActionsName: 'ok',
          posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              content: 'account_exists',
              title: 'error',
              posActionsName: 'ok',
              isError: true
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            content: '$e',
            title: 'error',
            posActionsName: 'ok',
            isError: true
        );
      }
    }
  }
}
