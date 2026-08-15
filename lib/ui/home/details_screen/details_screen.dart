import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/add_screen/widgets/app_bar_custom.dart';
import 'package:evently/ui/home/add_screen/widgets/image_container.dart';
import 'package:evently/ui/home/details_screen/widgets/icon_button_custom.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Stream<Event?>? stream;
  String? uId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (stream == null) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      uId = userProvider.currentUser!.id;

      String eventId = ModalRoute.of(context)!.settings.arguments as String;

      updateStream(uId!, eventId);
    }
  }

  void updateStream(String uId, String eventId) {
    stream = FirebaseUtils.getEventByIdInFirebase(eventId, uId);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return StreamBuilder<Event?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }

        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text(
                'event_not_found'.tr(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }

        Event event = snapshot.data!;

        String date = DateFormat(
          'dd MMMM',
          context.locale.languageCode,
        ).format(event.dateTime);

        String time = TimeOfDay(
          hour: event.dateTime.hour,
          minute: event.dateTime.minute,
        ).format(context);

        return Scaffold(
          appBar: AppBarCustom(
            text: 'event_details',
            actions: [
              IconButtonCustom(
                icon: AppAssets.editIcon,
                color: Theme.of(context).primaryColor,
                onTap: () {
                  DialogUtils.showMessage(
                    context: context,
                    title: 'edit',
                    content: 'edit_event',
                    posActionsName: 'yes',
                    negActionsName: 'no',
                    posAction: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.editRouteName,
                        arguments: event,
                      );
                    },
                  );
                },
              ),
              IconButtonCustom(
                icon: AppAssets.trashIcon,
                color: AppColors.redColor,
                onTap: () {
                  return deleteEvent(context, event.eventId, uId!);
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.043),
            child: Column(
              spacing: context.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageContainer(
                  imageLight: event.image['light'],
                  imageDark: event.image['dark'],
                ),

                Text(event.title, style: Theme.of(context).textTheme.bodyLarge),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.043,
                    vertical: context.height * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Row(
                    spacing: context.width * 0.043,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Image.asset(
                          AppAssets.calendarIcon,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      Column(
                        spacing: context.height * 0.004,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: themeProvider.isDarkMode
                                ? Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    color: AppColors.mainDarkModeColor,
                                  )
                                : Theme.of(context).textTheme.labelLarge,
                          ),

                          Text(
                            time,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  spacing: context.height * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'description'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),

                    Container(
                      width: double.infinity,
                      height: context.height * 0.3,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          event.description,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteEvent(BuildContext context, String eventId, String uId) {
    DialogUtils.showMessage(
      context: context,
      title: 'delete',
      content: 'delete_event',
      posActionsName: 'yes',
      negActionsName: 'no',
      posAction: () async {
        await FirebaseUtils.deleteEventInFirestore(eventId, uId);
        ToastUtils.showToast(
          text: 'delete_event_toast',
          backgroundColor: Theme.of(context).primaryColor,
        );
        Navigator.pop(context);
      },
    );
  }
}
