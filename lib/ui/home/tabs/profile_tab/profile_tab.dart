import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/profile_tab/widgets/tile_list_widget.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 0.075,
        right: context.width * 0.04,
        left: context.width * 0.04,
      ),
      child: Column(
        spacing: context.height * 0.018,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppAssets.profileImage),
          ),
          Column(
            spacing: context.height * 0.006,
            children: [
              Text(
                userProvider.currentUser!.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                userProvider.currentUser!.email,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: context.height * 0.012),
          TileListWidget(
            title: 'dark_mode',
            widget: Switch(
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              inactiveThumbColor: AppColors.whiteColor,
              inactiveTrackColor: AppColors.grayColor,
              activeTrackColor: AppColors.mainDarkModeColor,
              value: themeProvider.isDarkMode,
              onChanged: (isDarkMode) {
                if (isDarkMode) {
                  themeProvider.changeTheme(ThemeMode.dark);
                } else {
                  themeProvider.changeTheme(ThemeMode.light);
                }
                setState(() {});
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: TileListWidget(
              title: 'language',
              widget: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              DialogUtils.showMessage(
                context: context,
                content: 'want_to_logout?',
                title: 'logout',
                posActionsName: 'yes',
                negActionsName: 'no',
                posAction: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginRouteName,
                    (route) => false,
                  );
                },
              );
            },
            child: TileListWidget(
              title: 'logout',
              widget: Icon(Icons.logout, color: AppColors.redColor),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }
}
