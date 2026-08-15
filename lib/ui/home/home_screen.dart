import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addRouteName);
        },
        backgroundColor: Theme.of(context).primaryColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 24),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              buildBottomNavigationBarItem(
                context: context,
                icon: AppAssets.homeIcon,
                activeIcon: AppAssets.activeHomeIcon,
                label: 'home',
              ),
              buildBottomNavigationBarItem(
                context: context,
                icon: AppAssets.favoriteIcon,
                activeIcon: AppAssets.activeFavoriteIcon,
                label: 'favorite',
              ),
              buildBottomNavigationBarItem(
                context: context,
                icon: AppAssets.profileIcon,
                activeIcon: AppAssets.activeProfileIcon,
                label: 'profile',
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: tabs[selectedIndex]),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required BuildContext context,
    required String icon,
    required String activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(
          top: context.height * 0.01,
          bottom: context.height * 0.004,
        ),
        child: Image.asset(icon, color: AppColors.disableColor),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(
          top: context.height * 0.01,
          bottom: context.height * 0.004,
        ),
        child: Image.asset(activeIcon, color: Theme.of(context).primaryColor),
      ),
      label: label.tr(),
    );
  }
}
