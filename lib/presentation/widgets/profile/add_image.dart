import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/core/utils/take_photo_bottomsheet.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String? _pathFile;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        takePhotoBottomSheet(context, onSave: (filePath) {
          //save file path to model state
          if (filePath != null) {
            // state.addFilePath(filePath);
            log('filePath: $filePath');
            setState(() {
              _pathFile = filePath[0];
            });
            var data = AboutData();
            context.read<AboutBloc>().add(
                  AddAboutData(
                    aboutData: data.copyWith(
                      pathImage: _pathFile,
                    ),
                  ),
                );
          }
        });
      },
      child: Row(
        children: [
          _pathFile != null
              ? SizedBox(
                  height: 58.w,
                  width: 57.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.file(
                      File(_pathFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: 58.w,
                  width: 57.w,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: dark, borderRadius: BorderRadius.all(Radius.circular(17))),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: goldensColor,
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
          const SizedBox(width: 15),
          Text(
            'Add Image',
            style: whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium),
          )
        ],
      ),
    );
  }
}
