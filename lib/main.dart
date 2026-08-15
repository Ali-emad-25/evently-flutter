import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/add_screen/add_screen.dart';
import 'package:evently/ui/home/details_screen/details_screen.dart';
import 'package:evently/ui/home/edit_screen/edit_screen.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/login/forget_password_screen.dart';
import 'package:evently/ui/login/login_screen.dart';
import 'package:evently/ui/login/register_screen.dart';
import 'package:evently/ui/onboarding/onboarding_screen.dart';
import 'package:evently/ui/onboarding/start_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
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
        AppRoutes.addRouteName: (context) => AddScreen(),
        AppRoutes.detailsRouteName: (context) => DetailsScreen(),
        AppRoutes.editRouteName: (context) => EditScreen(),
      },
    );
  }
}
