// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'about_bloc.dart';

class AboutEvent {}

class AddAboutData extends AboutEvent {
  final AboutData aboutData;
  AddAboutData({
    required this.aboutData,
  });
}

class AboutEditPressed extends AboutEvent {
  final bool isEdit;
  AboutEditPressed({
    required this.isEdit,
  });
}

class AboutSavePressed extends AboutEvent {
  AboutSavePressed();
}
