import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/tabs/profile_tab/widgets/tile_list_widget.dart';
import 'package:evently/utils/AppAssets.dart';
import 'package:evently/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 16, left: 16),
      child: Column(
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(Appassets.profileImage),
          ),
          Column(
            spacing: 5,
            children: [
              Text(
                'Ali Emad',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'aliemad25@gmail.com',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(height: 10),
          TileListWidget(
            title: 'darkMode',
            widget: Switch(
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              inactiveThumbColor: Appcolors.whiteColor,

              inactiveTrackColor: Appcolors.grayColor,
              activeTrackColor: Appcolors.mainDarkModeColor,
              value: themeProvider.themeMode == ThemeMode.dark,
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
              //   todo: logout
            },
            child: TileListWidget(
              title: 'logout',
              widget: Icon(Icons.logout, color: Appcolors.redColor),
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
