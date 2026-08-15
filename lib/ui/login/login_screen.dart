import 'package:easy_localization/easy_localization.dart';
import 'package:evently/auth_service.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/login/widgets/google_btn.dart';
import 'package:evently/ui/login/widgets/text_button_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/ui/onboarding/widgets/logo_widget.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: LogoWidget(), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.043),
        child: SingleChildScrollView(
          child: Column(
            spacing: context.height * 0.025,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height * 0.025),
              Text(
                'login_title',
                style: Theme.of(context).textTheme.titleLarge,
              ).tr(),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: context.height * 0.02,
                  children: [
                    TextFieldWidget(
                      hintText: 'email_hint',
                      prefixIcon: Image.asset(AppAssets.emailIcon),
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please enter email.";
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(emailController.text);
                        if (!emailValid) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hintText: 'password_hint',
                      prefixIcon: Image.asset(AppAssets.passwordIcon),
                      textInputType: TextInputType.emailAddress,
                      isPasswordField: true,
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please enter password.";
                        }
                        if (text.length < 6) {
                          return "Password must be at least 6 chars.";
                        }
                        return null;
                      },
                    ),
                    TextButtonWidget(
                      text: 'forget_password',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgetPasswordRouteName,
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height * 0.012),
              MainBtn(
                text: 'login',
                onPressed: () {
                  login(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: context.width * 0.013,
                children: [
                  Text(
                    'not_account',
                    style: Theme.of(context).textTheme.labelMedium,
                  ).tr(),
                  TextButtonWidget(
                    text: 'signup',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.registerRouteName,
                      );
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: context.height * 0.012),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.043,
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        'or',
                        style: Theme.of(context).textTheme.titleMedium,
                      ).tr(),
                    ),
                  ],
                ),
              ),
              GoogleBtn(
                text: 'login_google',
                onPressed: () {
                  AuthService.continueWithGoogle(context);
                },
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, text: 'loading...');
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var myUser = await FirebaseUtils.getUserInFirestore(
          credential.user?.uid ?? '',
        );
        if (myUser == null) {
          return;
        }
        Provider.of<UserProvider>(context, listen: false).userUpdate(myUser);

        DialogUtils.hideLoading(context: context);
        ToastUtils.showToast(
          text: 'login_successfully',
          backgroundColor: Theme.of(context).primaryColor,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          ToastUtils.showToast(
            text: 'no_user_found',
            backgroundColor: AppColors.redColor,
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        ToastUtils.showToast(text: '$e', backgroundColor: AppColors.redColor);
      }
    }
  }
}
