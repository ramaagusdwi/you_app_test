import 'package:flutter/material.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

void takePhotoBottomSheet(BuildContext context, {required Function(List<String?>?) onSave}) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      backgroundColor: backgroundColor2,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: white,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                            "Select Photo",
                            textAlign: TextAlign.center,
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        // Utils.checkAndRequestCameraPermissions().then((v) async {
                        //   if (v) {
                        //     Utils.pickMedia(isCamera: true).then((v) {
                        //       if (v != null) {
                        //         // mystate(() {
                        //         //   onSave(v);
                        //         //   Navigator.pop(context);
                        //         // });
                        //         List<String> pathList = [v];
                        //         onSave(pathList);
                        //         Navigator.pop(context);
                        //       }
                        //     });
                        //   } else {
                        //     bool isShown = await Permission.contacts.shouldShowRequestRationale;
                        //     await Permission.camera.request();
                        //   }
                        // });
                        Utils.pickMedia(isCamera: true).then((v) {
                          if (v != null) {
                            // mystate(() {
                            //   onSave(v);
                            //   Navigator.pop(context);
                            // });
                            List<String> pathList = [v];
                            onSave(pathList);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset("assets/camera.png", height: 30, width: 30),
                            const SizedBox(width: 20.0),
                            Text(
                              "Take from Camera",
                              style: whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Utils.checkAndRequestCameraPermissions().then((v) {
                        //   if (v) {
                        //     // Utils.pickMedia(isCamera: false).then((v) {
                        //     //   if (v != null) {
                        //     //     // mystate(() {
                        //     //     //   onSave(v);
                        //     //     //   Navigator.pop(context);
                        //     //     // });
                        //     //     onSave(v);
                        //     //     Navigator.pop(context);
                        //     //   }
                        //     // });
                        //     Utils.pickMultiImage().then((v) {
                        //       if (v != null) {
                        //         // mystate(() {
                        //         //   onSave(v);
                        //         //   Navigator.pop(context);
                        //         // });
                        //         onSave(v);
                        //         Navigator.pop(context);
                        //       }
                        //     });
                        //   }
                        // });

                        Utils.pickMedia(isCamera: false).then((v) {
                          if (v != null) {
                            // mystate(() {
                            //   onSave(v);
                            //   Navigator.pop(context);
                            // });
                            onSave([v]);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset("assets/gallery.png", width: 30, height: 30),
                            const SizedBox(width: 20.0),
                            // vText("Ambil dari Galeri", fontSize: 14.0, fontWeight: FontWeight.w400),
                            Text(
                              "Take from Gallery",
                              style: whiteTextStyle.copyWith(fontSize: 12.0, fontWeight: regular),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          );
        });
      });
}
