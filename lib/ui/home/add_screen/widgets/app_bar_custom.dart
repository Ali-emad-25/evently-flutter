import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/onboarding/widgets/back_btn.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;

  const AppBarCustom({super.key, required this.text, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text.tr(), style: Theme.of(context).textTheme.bodyLarge),
      centerTitle: true,
      leadingWidth: context.width * 0.17,
      leading: BackBtn(
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
      actionsPadding: EdgeInsets.only(
        left: context.width * 0.016,
        right: context.width * 0.043,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
