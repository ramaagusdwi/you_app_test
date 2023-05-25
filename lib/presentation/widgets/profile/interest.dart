import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/core/route/routes.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestBloc, List<String>>(
      builder: (context, state) {
        return IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.fromLTRB(27, 17, 27, 23),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: blackPearlColor,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interest',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, Routes.interest),
                        child: Container(
                          height: 17,
                          width: 17,
                          child: Image.asset('assets/edit.png'),
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  SizedBox(height: 24.w),
                  if (state.isEmpty) ...[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Add in your interest to find a better match',
                        style: whiteOpacity52TextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    )
                  ] else ...[
                    chipList(state),
                  ]
                ]),
          ),
        );
      },
    );
  }

  chipList(List<String> state) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child:
          Wrap(spacing: 12.0, runSpacing: 6.0, children: state.map((e) => _buildChip(e)).toList()),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      backgroundColor: const Color(0xE61C272C),
      label: Text(label),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
