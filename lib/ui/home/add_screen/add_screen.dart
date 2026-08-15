import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/add_screen/widgets/app_bar_custom.dart';
import 'package:evently/ui/home/add_screen/widgets/image_container.dart';
import 'package:evently/ui/home/add_screen/widgets/tile_list_widget.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/tab_item_widget.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/ui/onboarding/widgets/main_btn.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formateDate;
  TimeOfDay? selectedTime;
  String? formateTime;
  late Map<String, String> selectedEventImage;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> eventsNameList = [
    'sport'.tr(),
    'birthday'.tr(),
    'book_club'.tr(),
    'meeting'.tr(),
    'exhibition'.tr(),
  ];

  List<String> eventsIconList = [
    AppAssets.sportIcon,
    AppAssets.birthdayIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
    AppAssets.bookIcon,
  ];

  List<String> eventsBgLightList = [
    AppAssets.sportBgLight,
    AppAssets.birthdayBgLight,
    AppAssets.bookClubBgLight,
    AppAssets.meetingBgLight,
    AppAssets.exhibitionBgLight,
  ];

  List<String> eventsBgDarkList = [
    AppAssets.sportBgDark,
    AppAssets.birthdayBgDark,
    AppAssets.bookClubBgDark,
    AppAssets.meetingBgDark,
    AppAssets.exhibitionBgDark,
  ];

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    selectedEventImage = {
      "light": eventsBgLightList[selectedIndex],
      "dark": eventsBgDarkList[selectedIndex],
    };
    return Scaffold(
      appBar: AppBarCustom(text: 'add_event'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.043),
        child: SingleChildScrollView(
          child: Column(
            spacing: context.height * 0.02,
            children: [
              ImageContainer(
                imageLight: eventsBgLightList[selectedIndex],
                imageDark: eventsBgDarkList[selectedIndex],
              ),
              SizedBox(
                height: context.height * 0.05,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: TabItemWidget(
                        icon: eventsIconList[index],
                        eventName: eventsNameList[index],
                        isSelected:
                            selectedIndex ==
                            eventsNameList.indexOf(eventsNameList[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: context.width * 0.03);
                  },
                  itemCount: eventsNameList.length,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  spacing: context.height * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'title'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextFieldWidget(
                      hintText: 'event_title',
                      controller: titleController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "enter_title".tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(),
                    Text(
                      'description'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextFieldWidget(
                      hintText: 'event_description',
                      maxLines: 5,
                      controller: descriptionController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "enter_description".tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              TileListChoiceWidget(
                icon: AppAssets.calendarIcon,
                text: 'event_date',
                choiceText: selectedDate == null
                    ? 'choose_date'.tr()
                    : formateDate!,
                onTap: chooseDate,
              ),
              TileListChoiceWidget(
                icon: AppAssets.clockIcon,
                text: 'event_time',
                choiceText: selectedTime == null
                    ? 'choose_time'.tr()
                    : formateTime!,
                onTap: chooseTime,
              ),
              SizedBox(),
              MainBtn(
                text: 'add_event_btn',
                onPressed: () {
                  return addEvent(userProvider.currentUser!.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent(String uId) {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
        eventCategoryIndex: selectedIndex + 1,
        image: selectedEventImage,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
      );
      FirebaseUtils.addEventInFirestore(event, uId)
          .then((value) {
            ToastUtils.showToast(
              text: 'added_event',
              backgroundColor: Theme.of(context).primaryColor,
            );
            Navigator.pop(context);
          })
          .catchError((e) {
            ToastUtils.showToast(
              text: '$e',
              backgroundColor: AppColors.redColor,
            );
          });
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chooseDate != null) {
      selectedDate = chooseDate;
      formateDate = DateFormat(
        'MMM d, yyyy',
        context.locale.languageCode,
      ).format(chooseDate);
      setState(() {});
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectedTime = chooseTime;
      formateTime = chooseTime.format(context);
      setState(() {});
    }
  }
}
