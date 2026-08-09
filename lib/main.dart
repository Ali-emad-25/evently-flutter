import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/login/forget_password_screen.dart';
import 'package:evently/ui/login/login_screen.dart';
import 'package:evently/ui/login/register_screen.dart';
import 'package:evently/ui/onboarding/onboarding_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/onboarding/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.startRouteName,
      routes: {
        AppRoutes.startRouteName: (context) => StartScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
      },
    );
  }
}
