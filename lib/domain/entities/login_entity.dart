import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String phoneNumber;
  String password;
  String? outletCode;
  LoginEntity({
    required this.phoneNumber,
    required this.password,
    this.outletCode,
  });

  Map<String, dynamic> get json => {
        'phone_no': phoneNumber,
        'password': password,
        if (outletCode != null) 'outlet_code': outletCode,
      };

  factory LoginEntity.fromMap(Map<String, dynamic> data) => LoginEntity(
        phoneNumber: data['phone_no'],
        password: data['password'],
        outletCode: data['outlet_code'],
      );

  @override
  List<Object?> get props => [phoneNumber, password, outletCode];
}
