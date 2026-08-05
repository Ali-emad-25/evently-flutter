import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  String imageLight;
  String imageDark;
  String title;
  String description;
  int count;
  PageController controller;

  OnboardingPage({
    super.key,
    required this.imageLight,
    required this.imageDark,
    required this.title,
    required this.description,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          SizedBox(height: 20),
          Image.asset(
            themeProvider.isDarkMode ? imageDark : imageLight,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: .center,
            padding: EdgeInsets.only(bottom: 10),
            child: SmoothPageIndicator(
              controller: controller,
              count: count,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).primaryColor,
                expansionFactor: 2.5,
                dotColor: themeProvider.isDarkMode
                    ? AppColors.whiteColor
                    : AppColors.disableColor,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 6,
              ),
            ),
          ),
          Text(title, style: Theme.of(context).textTheme.headlineLarge).tr(),
          Text(description, style: Theme.of(context).textTheme.labelSmall).tr(),
        ],
      ),
    );
  }
}
