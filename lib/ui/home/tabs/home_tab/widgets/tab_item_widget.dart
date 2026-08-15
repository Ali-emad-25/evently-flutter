import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  String eventName;
  String icon;
  bool isSelected;

  TabItemWidget({
    super.key,
    required this.icon,
    required this.eventName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.height * 0.01,
        horizontal: context.width * 0.035,
      ),
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
        spacing: context.width * 0.025,
        children: [
          Image.asset(
            icon,
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
