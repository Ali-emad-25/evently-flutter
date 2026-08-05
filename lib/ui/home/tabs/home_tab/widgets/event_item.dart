import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        color: AppColors.mainDarkModeColor,
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(AppAssets.sportBgLight),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text(
              '21 Jan',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'This is a Birthday Party',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
