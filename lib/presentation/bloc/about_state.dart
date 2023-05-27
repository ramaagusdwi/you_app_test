part of 'about_bloc.dart';

//status => isEditing show form about , for purpose input data like display name, gender, etc.
enum AboutStatus { initial, loading, success, failure, isEditing, doneEdit }

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AboutState extends Equatable {
  final AboutData aboutData;
  final AboutStatus? status;

  const AboutState({
    required this.aboutData,
    this.status = AboutStatus.initial,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        aboutData,
        status,
      ];

  factory AboutState.init() {
    return AboutState(
      aboutData: AboutData.empty(),
      status: AboutStatus.initial,
    );
  }

  AboutState copyWith({
    AboutData? aboutData,
    AboutStatus? status,
  }) {
    return AboutState(
      aboutData: aboutData ?? this.aboutData,
      status: status ?? this.status,
    );
  }
}
