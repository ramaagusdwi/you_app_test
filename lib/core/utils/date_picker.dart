// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as flutter_datetime_picker;
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class DatePickerHelper {
//   static show(BuildContext context, Function(DateTime dateTime) onConfirmed) {
//     flutter_datetime_picker.DatePicker.showDatePicker(context,
//         showTitleActions: true,
//         minTime: DateTime(1990, 1, 1),
//         maxTime: DateTime(2050, 6, 7),
//         theme: const flutter_datetime_picker.DatePickerTheme(
//             headerColor: Colors.white,
//             backgroundColor: Colors.white,
//             itemStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
//             doneStyle: TextStyle(color: Colors.black, fontSize: 16)), onChanged: (date) {
//       print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
//     }, onConfirm: (date) {
//       onConfirmed(date);
//       // state.setDueDate(DateFormat("yyyy-MM-dd", "id_ID").format(date));
//       // state.setDueDate(DateFormat(
//       //   "yyyy-MM-dd",
//       // ).format(date));
//     }, currentTime: DateTime.now(), locale: LocaleType.id
//         // locale: const Locale("id", "ID"),
//         );
//   }
// }
