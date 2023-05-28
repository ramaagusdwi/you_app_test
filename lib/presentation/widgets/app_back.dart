import 'package:flutter/widgets.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/back_button_chevron.dart';

class AppBack extends StatelessWidget {
  VoidCallback onTap;
  AppBack({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // onTap: () {
      //   context.read<InterestBloc>().add(InterestRemovedAllTemp());
      //   Navigator.pop(context);
      // },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButtonChevron(
            onBackPressed: onTap,
            backButtonColor: white,
          ),
          Text(
            'Back',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
        ],
      ),
    );
  }
}
