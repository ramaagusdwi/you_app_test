import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/utils/take_photo_bottomsheet.dart';

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
                  child: const Icon(Icons.add, color: white),
                ),
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
