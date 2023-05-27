// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AboutData extends Equatable {
  final String? pathImage;
  final String? displayName;
  final String? gender;
  final DateTime? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;

  AboutData({
    this.pathImage,
    this.displayName,
    this.gender,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        pathImage,
        displayName,
        gender,
        birthday,
        horoscope,
        zodiac,
        height,
        weight,
      ];

  // factory AboutData.empty() {
  //   return AboutData(
  //       pathImage: '',
  //       displayName: '',
  //       gender: '',
  //       birthday: '',
  //       horoscope: '',
  //       zodiac: '',
  //       height: 0,
  //       weight: 0);
  // }

  factory AboutData.empty() {
    return AboutData(
        pathImage: null,
        displayName: null,
        gender: null,
        birthday: null,
        horoscope: null,
        zodiac: null,
        height: null,
        weight: null);
  }

  AboutData copyWith({
    String? pathImage,
    String? displayName,
    String? gender,
    DateTime? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
  }) {
    return AboutData(
      pathImage: pathImage ?? this.pathImage,
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      horoscope: horoscope ?? this.horoscope,
      zodiac: zodiac ?? this.zodiac,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pathImage': pathImage,
      'displayName': displayName,
      'gender': gender,
      'birthday': birthday,
      'horoscope': horoscope,
      'zodiac': zodiac,
      'height': height,
      'weight': weight,
    };
  }

  factory AboutData.fromMap(Map<String, dynamic> map) {
    return AboutData(
      pathImage: map['pathImage'] as String,
      displayName: map['displayName'] as String,
      gender: map['gender'] as String,
      birthday: map['birthday'] as DateTime,
      horoscope: map['horoscope'] as String,
      zodiac: map['zodiac'] as String,
      height: map['height'] as int,
      weight: map['weight'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutData.fromJson(String source) =>
      AboutData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AboutParams(pathImage: $pathImage, displayName: $displayName, gender: $gender, birthday: $birthday, horoscope: $horoscope, zodiac: $zodiac, height: $height, weight: $weight)';
  }

  @override
  bool operator ==(covariant AboutData other) {
    if (identical(this, other)) return true;

    return other.pathImage == pathImage &&
        other.displayName == displayName &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.horoscope == horoscope &&
        other.zodiac == zodiac &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return pathImage.hashCode ^
        displayName.hashCode ^
        gender.hashCode ^
        birthday.hashCode ^
        horoscope.hashCode ^
        zodiac.hashCode ^
        height.hashCode ^
        weight.hashCode;
  }
}
