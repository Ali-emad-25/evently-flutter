import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/tab_item_widget.dart';
import 'package:evently/utils/app_assets.dart';
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
  List<Event> eventList = [];
  Stream<List<Event>>? stream;

  List<String> eventsNameList = [
    'all'.tr(),
    'sport'.tr(),
    'birthday'.tr(),
    'book_club'.tr(),
    'meeting'.tr(),
    'exhibition'.tr(),
  ];

  List<String> eventsIconList = [
    AppAssets.allIcon,
    AppAssets.sportIcon,
    AppAssets.birthdayIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    updateStream(selectedIndex, userProvider.currentUser!.id);
  }

  void updateStream(int index, String uId) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      stream = FirebaseUtils.getAllEventsInFirestore(uId);
    } else {
      stream = FirebaseUtils.getEventsByFilterInFirestore(selectedIndex, uId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
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
                      userProvider.currentUser!.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                Row(
                  spacing: context.width * 0.03,
                  children: [
                    themeProvider.isDarkMode
                        ? Icon(
                            Icons.dark_mode_outlined,
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          )
                        : Icon(
                            Icons.wb_sunny_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: context.height * 0.0062,
                        horizontal: context.width * 0.02,
                      ),
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
              labelPadding: EdgeInsets.symmetric(
                vertical: context.height * 0.031,
                horizontal: context.width * 0.01,
              ),
              indicatorColor: AppColors.transparent,
              dividerColor: AppColors.transparent,
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                updateStream(index, userProvider.currentUser!.id);
                setState(() {});
              },
              tabs: eventsNameList.map((eventName) {
                return TabItemWidget(
                  icon: eventsIconList[eventsNameList.indexOf(eventName)],
                  eventName: eventName,
                  isSelected:
                      selectedIndex == eventsNameList.indexOf(eventName),
                );
              }).toList(),
            ),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'no_events'.tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  } else {
                    eventList = snapshot.data!;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return EventItem(
                          event: eventList[index],
                          isLastItem: index == eventList.length - 1,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: context.height * 0.017);
                      },
                      itemCount: eventList.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
