import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently/ui/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/tabs/profile_tab/profile_tab.dart';
import 'package:evently/utils/AppAssets.dart';
import 'package:evently/utils/AppColors.dart';
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
          // todo: Navigation to add screen
        },
        backgroundColor: Theme.of(context).primaryColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Appcolors.whiteColor, size: 24),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            buildBottomNavigationBarItem(
              context: context,
              icon: Appassets.homeIcon,
              activeIcon: Appassets.activeHomeIcon,
              label: 'home',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: Appassets.favoriteIcon,
              activeIcon: Appassets.activeFavoriteIcon,
              label: 'favorite',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: Appassets.profileIcon,
              activeIcon: Appassets.activeProfileIcon,
              label: 'profile',
            ),
          ],
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
        padding: const EdgeInsets.only(top: 8, bottom: 3),
        child: Image.asset(icon, color: Appcolors.disableColor),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 3),
        child: Image.asset(activeIcon, color: Theme.of(context).primaryColor),
      ),
      label: label.tr(),
    );
  }
}
