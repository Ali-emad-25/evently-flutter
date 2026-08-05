import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  String eventName;
  int eventIconIndex;
  bool isSelected;

  TabItemWidget({
    super.key,
    required this.eventName,
    required this.eventIconIndex,
    required this.isSelected,
  });

  List<String> eventsIconList = [
    AppAssets.allIcon,
    AppAssets.sportIcon,
    AppAssets.birthdayIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
          width: 1,
        ),
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
      ),
      child: Row(
        spacing: 8,
        children: [
          Image.asset(
            eventsIconList[eventIconIndex],
            color: isSelected
                ? AppColors.whiteColor
                : Theme.of(context).primaryColor,
          ),
          Text(
            eventName,
            style: isSelected
                ? Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.whiteColor)
                : Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
