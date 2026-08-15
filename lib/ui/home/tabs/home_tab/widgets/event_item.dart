import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  Event event;
  bool isLastItem;

  EventItem({super.key, required this.event, required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    String formateDate = DateFormat(
      'dd MMM',
      context.locale.languageCode,
    ).format(event.dateTime);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.detailsRouteName,
              arguments: event.eventId,
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: context.height * 0.235,
            decoration: BoxDecoration(
              color: AppColors.mainDarkModeColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(
                  themeProvider.isDarkMode
                      ? event.image['dark']!
                      : event.image['light']!,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.012,
                    horizontal: context.width * 0.02,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Text(
                    formateDate,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.012,
                    horizontal: context.width * 0.03,
                  ),
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
                        event.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      InkWell(
                        onTap: () {
                          final primaryColor = Theme.of(context).primaryColor;
                          FirebaseUtils.addFavoriteEventInFirestore(
                                event,
                                userProvider.currentUser!.id,
                              )
                              .then((value) {
                                ToastUtils.showToast(
                                  text: event.isFavorite == true
                                      ? 'removed_favorites'
                                      : 'added_favorites',
                                  backgroundColor: primaryColor,
                                );
                              })
                              .catchError((e) {
                                ToastUtils.showToast(
                                  text: e.toString(),
                                  backgroundColor: AppColors.redColor,
                                );
                              });
                        },
                        child: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isLastItem,
          child: SizedBox(height: context.height * 0.1),
        ),
      ],
    );
  }
}
