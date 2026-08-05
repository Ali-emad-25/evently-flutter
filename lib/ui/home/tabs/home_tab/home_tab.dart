import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/tab_item_widget.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  List<String> eventsNameList = [
    'all'.tr(),
    'sport'.tr(),
    'birthday'.tr(),
    'book_club'.tr(),
    'meeting'.tr(),
    'exhibition'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.043,
        right: context.width * 0.043,
        top: context.height * 0.02,
      ),
      child: DefaultTabController(
        length: eventsNameList.length,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: context.height * 0.007,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'welcome_back',
                      style: Theme.of(context).textTheme.labelMedium,
                    ).tr(),
                    Text(
                      'Ali Emad',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    themeProvider.isDarkMode
                        ? Icon(
                            Icons.nightlight_outlined,
                            color: Theme.of(context).primaryColor,
                          )
                        : Icon(
                            Icons.wb_sunny_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        context.locale.languageCode == 'en' ? 'EN' : 'AR',
                        style: AppStyles.simi14White,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 3),
              indicatorColor: AppColors.transparent,
              dividerColor: AppColors.transparent,
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                selectedIndex = index;
                // todo: filter
                setState(() {});
              },
              tabs: eventsNameList.map((eventName) {
                return TabItemWidget(
                  eventName: eventName,
                  eventIconIndex: eventsNameList.indexOf(eventName),
                  isSelected:
                      selectedIndex == eventsNameList.indexOf(eventName),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
