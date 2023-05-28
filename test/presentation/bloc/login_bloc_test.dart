import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';
import 'package:flutter_you_app/presentation/bloc/login_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([Login])
void main() {
  late LoginBloc loginBloc;
  late MockLogin mockLogin;

  setUp(() {
    mockLogin = MockLogin();
    loginBloc = LoginBloc(mockLogin);
  });

  group('do login bloc test', () {
    blocTest<LoginBloc, LoginState>(
      'should emit FormzSubmissionStatus.success if login successfully',
      setUp: () {
        when(mockLogin.execute(any)).thenAnswer((_) async => const Right('success'));
      },
      build: () => loginBloc,
      act: (loginBloc) {
        final loginEntity = LoginEntity(email: 'testing@mail.com', password: 'abcd1234');
        loginBloc.add(
          LoginPressed(loginEntity),
        );
      },
      expect: () => [
        const LoginState(status: FormzSubmissionStatus.inProgress),
        const LoginState(status: FormzSubmissionStatus.success)
      ],
      verify: (_) {
        verify(mockLogin.execute(any)).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'should emit FormzSubmissionStatus.failure state if login failure',
      setUp: () {
        when(mockLogin.execute(
          any,
        )).thenAnswer((_) async => const Left(AppError('User not found')));
      },
      build: () => loginBloc,
      act: (loginBloc) {
        final loginEntity = LoginEntity(email: 'testing@mail.com1111', password: 'abcd1234');
        loginBloc.add(
          LoginPressed(loginEntity),
        );
      },
      expect: () => [
        const LoginState(status: FormzSubmissionStatus.inProgress),
        const LoginState(status: FormzSubmissionStatus.failure, errorMessage: 'User not found')
      ],
    );   
  });
}
