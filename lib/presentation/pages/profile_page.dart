import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_you_app/core/constant/image_constant.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';
import 'package:flutter_you_app/presentation/pages/login_page.dart';
import 'package:flutter_you_app/presentation/widgets/back_button_chevron.dart';
import 'package:flutter_you_app/core/theme.dart';
import 'package:flutter_you_app/presentation/widgets/profile/about.dart';
import 'package:flutter_you_app/presentation/widgets/profile/interest.dart';

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
                  // header(widget.username),
                  _Header(username: widget.username),
                  const SizedBox(height: 28),
                  //before add photo
                  isUpdateData
                      ? Flexible(
                          child: Container(
                            height: 190,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/men.jpg'),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Text(
                                    '@johndoe123, 28',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Male',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  chipList(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Flexible(
                          child: Container(
                            height: 190,
                            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                color: grey),
                            child: Column(
                              children: [
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    widget.username,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 24),
                  Flexible(child: About(
                    updateDataCallback: (value) {
                      setState(() {
                        isUpdateData = value;
                      });
                    },
                  )),
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

  // Widget header(String username) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       back(),
  //       Text(
  //         username,
  //         textAlign: TextAlign.center,
  //         style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
  //       ),
  //       PopupMenuButton<SampleItem>(
  //         initialValue: '',
  //         // Callback that sets the selected popup menu item.
  //         onSelected: (SampleItem item) {
  //           setState(() {
  //             selectedMenu = item;
  //           });
  //         },
  //         itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
  //           const PopupMenuItem<SampleItem>(
  //             value: SampleItem.itemOne,
  //             child: Text('Item 1'),
  //           ),
  //           const PopupMenuItem<SampleItem>(
  //             value: SampleItem.itemTwo,
  //             child: Text('Item 2'),
  //           ),
  //           const PopupMenuItem<SampleItem>(
  //             value: SampleItem.itemThree,
  //             child: Text('Item 3'),
  //           ),
  //         ],
  //       ),
  //       // Row(
  //       //   children: [
  //       //     Image.asset('assets/diamond.png', height: 8, width: 8),
  //       //     Image.asset('assets/diamond.png', height: 8, width: 8),
  //       //     Image.asset('assets/diamond.png', height: 8, width: 8),
  //       //   ],
  //       // )
  //     ],
  //   );
  // }

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

  Map<String, String> zodiac = {
    'aries': ImageConstant.aries,
    'taurus': ImageConstant.taurus,
    'gemini': ImageConstant.gemini,
    'cancer': ImageConstant.cancer,
    'leo': ImageConstant.leo,
    'virgo': ImageConstant.virgo,
    'libra': ImageConstant.libra,
    'scorpio': ImageConstant.scorpio,
    'sagitarius': ImageConstant.sagitarius,
    'capricorn': ImageConstant.capricorn,
    'aquarius': ImageConstant.aquarius,
    'pisces': ImageConstant.pisces,
    'rat': ImageConstant.rat,
    'ox': ImageConstant.ox,
    'tiger': ImageConstant.tiger,
    'rabbit': ImageConstant.rabbit,
    'dragon': ImageConstant.dragon,
    'snake': ImageConstant.snake,
    'horse': ImageConstant.horse,
    'goat': ImageConstant.goat,
    'monkey': ImageConstant.monkey,
    'rooster': ImageConstant.rooster,
    'dog': ImageConstant.dog,
    'pig': ImageConstant.pig,
  };

  Widget _buildChip(String label, Color color) {
    String labelLowerCase = label.toLowerCase();
    String assetZodiac = zodiac[labelLowerCase]!;
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      avatar: Image.asset(assetZodiac),
      label: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
    );
  }

  chipList() {
    return Wrap(
      spacing: 15.0,
      runSpacing: 6.0,
      children: <Widget>[
        _buildChip('sagitarius', Color(0xFF222421)),
        _buildChip('rooster', const Color(0xFF222421)),
      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        back(),
        Text(
          widget.username,
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        ),
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
