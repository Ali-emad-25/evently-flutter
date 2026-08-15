import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
              Text(
                text.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    String title = '',
    required String content,
    String? posActionsName,
    VoidCallback? posAction,
    String? negActionsName,
    VoidCallback? negAction,
    bool isError = false,
  }) {
    List<Widget> actions = [];
    if (posActionsName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionsName.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }
    if (negActionsName != null) {
      actions.insert(
        0,
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionsName.tr(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            title.tr(),
            style: isError
                ? Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppColors.redColor)
                : Theme.of(context).textTheme.labelMedium,
          ),
          content: Text(
            content.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: actions,
        );
      },
    );
  }
}
