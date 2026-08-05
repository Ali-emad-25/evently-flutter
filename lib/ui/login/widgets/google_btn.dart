import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GoogleBtn extends StatelessWidget {
  final String text;

  const GoogleBtn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: AppColors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10),
        backgroundColor: Theme.of(context).cardColor,
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.googleLogo),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 18),
          ).tr(),
        ],
      ),
    );
  }
}
