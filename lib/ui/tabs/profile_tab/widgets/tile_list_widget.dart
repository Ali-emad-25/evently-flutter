import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TileListWidget extends StatelessWidget {
  final String title;
  final Widget widget;

  const TileListWidget({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge).tr(),
          widget,
        ],
      ),
    );
  }
}
