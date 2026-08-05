import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function();

class TextButtonWidget extends StatelessWidget {
  String text;
  OnTap onTap;

  TextButtonWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).primaryColor,
          decorationThickness: 2,
        ),
      ).tr(),
    );
  }
}
