import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';

class InterestListInput extends StatelessWidget {
  const InterestListInput({super.key});

  @override
  Widget build(BuildContext context) {
    //interest temporary hanya menampilan dipage sini saja
    return BlocBuilder<InterestBloc, InterestState>(
      builder: (context, state) {
        if (state.interests.isEmpty && state.interestsTemp.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text('Select Interest', style: whiteOpacity40TextStyle),
            ),
            SizedBox(height: 8.w),
            if (state.status == InterestStatus.input) ...[
              _buildListInterest(state.interestsTemp, context),
            ] else ...[
              if (state.interests.isNotEmpty) ...[
                _buildListInterest(state.interests, context),
              ] else ...[
                _buildListInterest(state.interestsTemp, context),
              ]
            ],
          ],
        );
      },
    );
  }

  Padding _buildListInterest(List<String> dataList, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Wrap(
          direction: Axis.horizontal,
          spacing: 4,
          runSpacing: 8,
          children: dataList
              .map(
                (item) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: whiteOpacity10,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item,
                          style: whiteTextStyle.copyWith(fontSize: 12, fontWeight: semiBold)),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () {
                          //TO DO Call function remove interest from bloc
                          context.read<InterestBloc>().add(InterestRemoved(item));
                          // state.removeWhere((element) => element == item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            size: 16.w,
                            color: white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
