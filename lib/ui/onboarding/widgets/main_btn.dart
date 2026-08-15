import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class MainBtn extends StatelessWidget {
  String text;
  OnPressed onPressed;

  MainBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: context.height * 0.012),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              padding: EdgeInsets.symmetric(vertical: context.height * 0.012),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(text.tr(), style: AppStyles.medium20White).tr(),
          ),
        ),
      ),
    );
  }
}
