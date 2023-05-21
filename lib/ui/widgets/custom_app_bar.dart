import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/ui/widgets/back_button_chevron.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  Color? titleColor;
  Color? backgroundColor;
  bool withBackButton;
  Color? backButtonColor;
  bool backButtonChevron;
  List<Widget>? actions;
  TabBar? tabBar;
  Function()? onBackPressed;
  double? elevation;

  CustomAppBar({
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.backButtonColor,
    this.withBackButton = false,
    this.backButtonChevron = false,
    this.actions,
    this.tabBar,
    this.onBackPressed,
    this.elevation = 0,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: backgroundColor ?? blackColor,
        leading: _setLeading(context),
        elevation: elevation,
        title: Text(
          title ?? '',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 22,
            color: titleColor ?? white,
          ),
        ),
        actions: actions,
        bottom: tabBar);
  }

  StatelessWidget? _setLeading(BuildContext context) {
    if (withBackButton == false) return Container();

    return backButtonChevron
        ? BackButtonChevron(backButtonColor: backButtonColor)
        : BackButton(
            color: backButtonColor ?? white, // <-- SEE HERE
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
