import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function();

class IconButtonCustom extends StatelessWidget {
  final String icon;
  final Color color;
  final OnTap onTap;

  const IconButtonCustom({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.height * 0.006,
          horizontal: context.width * 0.01,
        ),
        margin: EdgeInsets.only(left: context.width * 0.027),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(width: 1, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(icon, color: color),
      ),
    );
  }
}
