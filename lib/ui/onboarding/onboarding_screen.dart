import 'package:evently/models/onboarding_model.dart';
import 'package:evently/ui/onboarding/widgets/back_btn.dart';
import 'package:evently/ui/onboarding/widgets/logo_widget.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/ui/onboarding/widgets/onboarding_page.dart';
import 'package:evently/ui/onboarding/widgets/text_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentPage = 0;

  List<OnboardingModel> pagesList = [
    OnboardingModel(
      imageLight: AppAssets.onboardingImage1Light,
      imageDark: AppAssets.onboardingImage1Dark,
      title: 'onboarding1_title',
      description: 'onboarding1_description',
    ),
    OnboardingModel(
      imageLight: AppAssets.onboardingImage2Light,
      imageDark: AppAssets.onboardingImage2Dark,
      title: 'onboarding2_title',
      description: 'onboarding2_description',
    ),
    OnboardingModel(
      imageLight: AppAssets.onboardingImage3Light,
      imageDark: AppAssets.onboardingImage3Dark,
      title: 'onboarding3_title',
      description: 'onboarding3_description',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 65,
        leading: Visibility(
          visible: currentPage != 0,
          child: BackBtn(
            onTap: () {
              controller.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ),
        title: LogoWidget(),
        centerTitle: true,
        actions: [
          Visibility(
            visible: currentPage != pagesList.length - 1,
            child: TextBtn(
              text: 'skip',
              isSelected: false,
              onPressed: () {
                controller.animateToPage(
                  2,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 10,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pagesList.length,
                onPageChanged: (indexPage) {
                  currentPage = indexPage;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    imageLight: pagesList[index].imageLight,
                    imageDark: pagesList[index].imageDark,
                    title: pagesList[index].title,
                    description: pagesList[index].description,
                    controller: controller,
                    count: pagesList.length,
                  );
                },
              ),
            ),
            MainBtn(
              text: currentPage == pagesList.length - 1
                  ? 'get_started'
                  : 'next',
              onPressed: () {
                if (currentPage == pagesList.length - 1) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.loginRouteName,
                  );
                } else {
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
