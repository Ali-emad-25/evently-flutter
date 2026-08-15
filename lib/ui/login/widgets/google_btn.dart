import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class GoogleBtn extends StatelessWidget {
  final String text;
  final OnPressed onPressed;

  const GoogleBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: AppColors.transparent,
        padding: EdgeInsets.symmetric(vertical: context.height * 0.012),
        backgroundColor: Theme.of(context).cardColor,
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        spacing: context.width * 0.03,
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
