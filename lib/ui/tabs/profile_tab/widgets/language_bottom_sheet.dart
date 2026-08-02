import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageBottomSheet extends StatelessWidget {
  LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: 10,
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          InkWell(
            onTap: () {
              context.setLocale(Locale('ar'));
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'arabic',
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  Visibility(
                    visible: context.locale.languageCode == 'ar',
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.setLocale(Locale('en'));
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'english',
                    style: Theme.of(context).textTheme.labelLarge,
                  ).tr(),
                  Visibility(
                    visible: context.locale.languageCode == 'en',
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
