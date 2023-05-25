import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';

class InterestList extends StatelessWidget {
  const InterestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestBloc, List<String>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(child: Text('no interest'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text('Select Interest', style: whiteOpacity40TextStyle),
            ),
            SizedBox(height: 8.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  runSpacing: 8,
                  children: state
                      .map((item) => Container(
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
                                  style:
                                      whiteTextStyle.copyWith(fontSize: 12, fontWeight: semiBold)),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () {
                                  //TO DO Call function remove interest from bloc
                                  context.read<InterestBloc>().add(InterestRemoved(item));
                                  // state.removeWhere((element) => element == item);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 14.w,
                                  color: white,
                                ),
                              )
                            ],
                          )))
                      .toList()),
            ),
          ],
        );
      },
    );
  }
}
