import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/constant/image_constant.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/presentation/pages/login_page.dart';
import 'package:flutter_you_app/presentation/widgets/profile/about.dart';
import 'package:flutter_you_app/presentation/widgets/profile/cover.dart';
import 'package:flutter_you_app/presentation/widgets/profile/interest.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/back_button_chevron.dart';

class ProfilePageArgument {
  String username;

  ProfilePageArgument(this.username);
}

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

class ProfilePage extends StatefulWidget {
  String username;
  ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUpdateData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: backgroundColor3,
          )),
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  _Header(username: widget.username),
                  const SizedBox(height: 28),
                  //cover photo profile user
                  Flexible(child: CoverProfile(username: widget.username)),
                  const SizedBox(height: 24),
                  const About(),
                  const SizedBox(height: 24),
                  const Flexible(child: Interest()),               
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget back() {
    return InkWell(
      onTap: () {},
      child: Container(
        // transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
        child: Row(
          children: [
            BackButtonChevron(
              onBackPressed: () {},
              backButtonColor: white,
            ),
            Text(
              'Back',
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  String username;
  _Header({
    super.key,
    required this.username,
  });

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AboutBloc>().state.status;
    final username = context.watch<AboutBloc>().state.aboutData.displayName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        back(),
        if (status == AboutStatus.initial || status == AboutStatus.isEditing) ...[
          Text(
          widget.username,
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        ),
        ],
        if (status == AboutStatus.doneEdit) ...[
          Text(
            username ?? widget.username,
            textAlign: TextAlign.center,
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
          ),
        ],

        PopupMenuButton<SampleItem>(
          color: Colors.white,
          initialValue: selectedMenu,
          // Callback that sets the selected popup menu item.
          onSelected: (SampleItem item) {
            if (item == SampleItem.itemOne) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder:
                      (BuildContext context, Animation animation, Animation secondaryAnimation) {
                    return const LoginPage();
                  }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation, Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                  (Route route) => false);
            }
            setState(() {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  Widget back() {
    return InkWell(
      onTap: () {},
      child: Container(
        // transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
        child: Row(
          children: [
            BackButtonChevron(
              onBackPressed: () {},
              backButtonColor: white,
            ),
            Text(
              'Back',
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
          ],
        ),
      ),
    );
  }
}
