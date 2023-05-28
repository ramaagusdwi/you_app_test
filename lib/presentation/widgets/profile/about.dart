import 'package:age_calculator/age_calculator.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/utils/utils.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/presentation/widgets/item_label_about.dart';
import 'package:flutter_you_app/presentation/widgets/profile/form_about.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/edit_widget.dart';

class About extends StatefulWidget {
  final ValueChanged<bool>? updateDataCallback;
  const About({super.key, this.updateDataCallback});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isEdit = false;
  // bool isUpdateData = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(27, 18, 14, 23),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: blackPearlColor,
      ),
      child: BlocBuilder<AboutBloc, AboutState>(builder: (context, AboutState state) {
        if (state.status == AboutStatus.isEditing) {
          return const FormAbout();
        } // false

        return const ContentAbout();
      }),
    );
  }
}

class ContentAbout extends StatelessWidget {
  const ContentAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(context),
        BlocBuilder<AboutBloc, AboutState>(
          builder: (context, state) {
            if (state.status == AboutStatus.doneEdit) {
              AboutData? data = state.aboutData;
              String weight = data.weight == null ? '' : data.weight.toString();
              String height = data.height == null ? '' : data.height.toString();
              String zodiac = data.zodiac ?? '';
              String horoscope = data.horoscope ?? '';
              DateTime? birthday = data.birthday;

              // Find out your age as of today's date 2021-03-08
              // var parsedDate = DateTime.parse(birthday);
              DateDuration? duration;
              String? dateDisplay;
              if (birthday != null) {
                duration = AgeCalculator.age(birthday);
                dateDisplay = Utils.dateToString(birthday, Utils.DISPLAY_DATE_FORMAT3);
              }

              //still use dummy data
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 33),
                    if (dateDisplay != null || duration != null) ...[
                      ItemLabelAbout(
                          labelLeftText: 'Birthday:',
                          labelRightText: '$dateDisplay (Age ${duration!.years})'),
                    ] else ...[
                      const ItemLabelAbout(labelLeftText: 'Birthday:', labelRightText: ''),
                    ],
                    const SizedBox(height: 15),
                    ItemLabelAbout(labelLeftText: 'Horoscope:', labelRightText: zodiac),
                    const SizedBox(height: 15),
                    ItemLabelAbout(labelLeftText: 'Zodiac:', labelRightText: horoscope),
                    const SizedBox(height: 15),
                    ItemLabelAbout(labelLeftText: 'Height:', labelRightText: '$height cm'),
                    const SizedBox(height: 15),
                    ItemLabelAbout(labelLeftText: 'Weight:', labelRightText: '$weight kg'),
                  ],
                ),
              );
            }

            return Text(
              'Add in your your to help others know you better',
              style: whiteOpacity52TextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            );
          },
        ),
      ],
    );
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'About',
          style: whiteTextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
          ),
        ),
        EditWidget(
          onTap: () => context.read<AboutBloc>().add(
                AboutEditPressed(isEdit: true),
              ),
        ),
      ],
    );
  }
}
